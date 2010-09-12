require "spec_helper"

describe "Vidibus::Service::Mongoid" do
  let(:realm) { "12ab69f099a4012d4df558b035f038ab" }
  let(:this) { Service.create!(:function => "manager", :url => "http://manager.local", :uuid => "344b4b8088fb012dd3e558b035f038ab", :secret => "EaDai5nz16DbQTWQuuFdd4WcAiZYRPDwZTn2IQeXbPE4yBg3rr", :realm_uuid => nil, :this => true) }
  let(:connector) { Service.create!(:function => "connector", :url => "http://connector.local", :uuid => "60dfef509a8e012d599558b035f038ab", :secret => nil, :realm_uuid => nil) }
  let(:uploader) { Service.create!(:function => "uploader", :url => "http://uploader.local", :uuid => "c0861d609247012d0a8b58b035f038ab", :secret => "A7q8Vzxgrk9xrw2FCnvV4bv01UP/LBUUM0lIGDmMcB2GsBTIqx", :realm_uuid => realm) }
  let(:client_mock) { this; mock.any_instance_of(Vidibus::Service::Client) }

  describe "validation" do
    it "should pass with valid attributes" do
      this.should be_valid
    end

    it "should fail without a valid URL" do
      this.url = "something"
      this.should be_invalid
    end

    it "should fail without a function" do
      this.function = ""
      this.should be_invalid
      this.errors[:function].should have(1).error
    end

    it "should pass with arbitrary functions" do
      this.function = :something
      this.should be_valid
    end

    it "should fail if a secret is given for Connector" do
      connector.secret = "something"
      connector.should be_invalid
      connector.errors[:secret].should have(1).error
      connector.errors[:secret].first.should eql("is not allowed for a Connector")
    end

    it "should pass with empty secret for Connector" do
      connector.secret = nil
      connector.should be_valid
    end

    it "should fail without a secret for services except Connector" do
      uploader.secret = nil
      uploader.should be_invalid
      uploader.errors[:secret].should have(1).error
    end

    it "should fail without a realm_uuid for services except Connector and this" do
      uploader.realm_uuid = nil
      uploader.should be_invalid
      uploader.errors[:realm_uuid].should have(1).error
    end

    it "should pass with empty realm_uuid for Connector" do
      connector.realm_uuid = nil
      connector.should be_valid
    end

    it "should pass if realm_uuid is given for Connector" do
      connector.realm_uuid = realm
      connector.should be_valid
    end

    it "should pass if a realm_uuid is given for this" do
      this.realm_uuid = realm
      this.should be_valid
    end

    it "should fail for duplicate UUIDs within same realm" do
      duplicate_service = Service.new(:uuid => uploader.uuid, :realm_uuid => realm)
      duplicate_service.should be_invalid
      duplicate_service.errors[:uuid].should have(1).error
    end
  end

  describe "#url" do
    it "should be set without trailing slash" do
      this.url = "http://manager.local/"
      this.url.should eql("http://manager.local")
    end

    it "should be stored without trailing slash" do
      this.update_attributes(:url => "http://manager.local/")
      this.reload.url.should eql("http://manager.local")
    end
  end

  describe "#connector?" do
    it "should return true if service is a Connector" do
      connector.connector?.should be_true
    end

    it "should return false if service is not a Connector" do
      uploader.connector?.should be_false
    end
  end

  describe "#get" do
    it "should trigger a GET request" do
      client_mock.get("/something", :query => { :gotta => "give" })
      uploader.get("/something", :query => { :gotta => "give" })
    end
  end

  describe "#post" do
    it "should trigger a POST request" do
      client_mock.post("/something", :query => { :do => "it" })
      uploader.post("/something", :query => { :do => "it" })
    end
  end

  describe "#put" do
    it "should trigger a PUT request" do
      client_mock.put("/something", :query => { :new => "stuff" })
      uploader.put("/something", :query => { :new => "stuff" })
    end
  end

  describe "#delete" do
    it "should trigger a DELETE request" do
      client_mock.delete("/something/else", {})
      uploader.delete("/something/else")
    end
  end

  describe ".this" do
    it "should return this service" do
      this
      Service.this.should eql(this)
    end

    it "should raise an error if this service has not been configured yet" do
      expect {Service.this}.to raise_error(Service::ConfigurationError)
    end
  end

  describe ".connector" do
    it "should return the Connector" do
      connector
      Service.connector.should eql(connector)
    end

    it "should raise an error if the Connector has not been configured yet" do
      expect {Service.connector}.to raise_error(Service::ConfigurationError)
    end
  end

  describe ".local" do
    before {uploader}

    it "should return a service matching given function without a realm" do
      connector
      Service.local(:connector).should eql(connector)
    end

    it "should return a service matching given function and realm" do
      Service.local(:uploader, realm).should eql(uploader)
    end

    it "should return no service if it does not match given realm" do
      Service.local(:uploader).should be_nil
    end

    it "should return no service if it does not match given function" do
      Service.local(:connector, realm).should be_nil
    end

    it "should return a service matching given UUID and realm" do
      Service.local(uploader.uuid, realm).should eql(uploader)
    end

    it "should return no service if it does not match given function" do
      Service.local("123", realm).should be_nil
    end
  end

  describe ".discover" do
    it "should first try to find a local service" do
      uploader
      mock(Service).local(:uploader, realm) {uploader}
      dont_allow(Service).remote(:uploader, realm)
      Service.discover(:uploader, realm).should eql(uploader)
    end

    it "if no local service can be found a remote one should be fetched" do
      mock(Service).local(:uploader, realm) {nil}
      mock(Service).remote(:uploader, realm) {uploader}
      Service.discover(:uploader, realm).should eql(uploader)
    end
  end

  describe ".remote" do
    it "should require a realm" do
      expect {Service.remote(:uploader, nil)}.to raise_error(ArgumentError)
    end

    it "should fetch service data from Connector and create a local service object" do
      connector and this
      stub_http_request(:get, "http://connector.local/services/uploader").
        with(:query => {:realm => "12ab69f099a4012d4df558b035f038ab", :service => "344b4b8088fb012dd3e558b035f038ab", :sign => "d27be37e9440765d38789f9000a5b3a86c741b3954c88f7b1769e4067ac9fbd0"}).
         to_return(:status => 200, :body => %({"uuid":"c0861d609247012d0a8b58b035f038ab", "url":"http://uploader.local", "function":"uploader", "secret":"kjO8AjgX68Yp7OQ1XF8dTfPBE5GCuCnd/OPko+A9yCaw8qnj9xoyMGZEXQpf\niVBOUcux1qlW8hfT6UPKGoVfYA==\n"}))
      Service.remote(:uploader, realm)

      uploader = Service.local(:uploader, realm)
      uploader.uuid.should eql("c0861d609247012d0a8b58b035f038ab")
      uploader.function.should eql("uploader")
      uploader.url.should eql("http://uploader.local")
      uploader.secret.should eql(Vidibus::Secure.decrypt("kjO8AjgX68Yp7OQ1XF8dTfPBE5GCuCnd/OPko+A9yCaw8qnj9xoyMGZEXQpf\niVBOUcux1qlW8hfT6UPKGoVfYA==\n", this.secret))
    end

    it "should raise an error requested service has already been stored" do
      connector and this and uploader
      stub_http_request(:get, "http://connector.local/services/uploader").
        with(:query => {:realm => "e75234809111012d05ac58b035f038ab", :service => "973a8710926e012d0a8c58b035f038ab", :sign => "a93d3a1a0124e969f97d68feab37638ec8737b1d8ddc582cd204fbb228ad7e2b"}).
         to_return(:status => 200, :body => %({"uuid":"c0861d609247012d0a8b58b035f038ab", "url":"http://uploader.local", "function":"uploader", "secret":"kjO8AjgX68Yp7OQ1XF8dTfPBE5GCuCnd/OPko+A9yCaw8qnj9xoyMGZEXQpf\niVBOUcux1qlW8hfT6UPKGoVfYA==\n"}))
      expect { Service.remote(:uploader, realm) }.to raise_error
    end
  end
end

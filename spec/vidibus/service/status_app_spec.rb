require "spec_helper.rb"

describe "Vidibus::Service::StatusApp" do
  include Rack::Test::Methods

  def app
    @app ||= Vidibus::Service::StatusApp
  end

  describe "GET 'ping'" do
    it "returns pong" do
      get "/ping"
      last_response.body.should eq({pong: true}.to_json)
      last_response.status.should eq(200)
    end
  end
end

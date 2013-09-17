module Vidibus
  module Service
    module Mongoid
      extend ActiveSupport::Concern
      include Vidibus::Secure::Mongoid

      class ConfigurationError < Error; end
      class ConnectorError < Error; end

      included do
        field :url
        field :uuid
        field :function
        field :realm_uuid
        field :this, :type => Boolean, :default => false

        attr_accessor :nonce
        attr_encrypted :secret

        validates :url, :uri => {:protocol => [:http, :https], :accessible => false}
        validates :uuid, :uuid => true, :uniqueness => {:scope => :realm_uuid}
        validates :realm_uuid, :uuid => {:allow_blank => true}
        validates :function, :presence => true
        validates :secret, :presence => true, :unless => :connector?
        validates :realm_uuid, :presence => true, :if => :realm_required?

        validate :dont_allow_secret_for_connector, :if => :connector?

        # Removes trailing slash from given value.
        def url=(value)
          value.gsub!(/\/+$/, "") if value
          self.write_attribute(:url, value)
        end

        # Returns true if this service is a connector
        def connector?
          @is_connector ||= function == "connector"
        end

        # Returns publicly requestable data.
        def public_data
          attributes.only(%w[uuid function url])
        end

        # Returns url without protocol.
        def domain
          url.gsub(/https?:\/\//, "") if url
        end

        # Returns a Client for current service.
        def client
          @client ||= Client.new(self)
        end

        # Returns true if given client_secret matches signature.
        # This method is called from Vidibus' OauthServer when issuing an OAuth token.
        # To prevent sending the service's secret over the network, the ConnectorClient
        # sends a signature instead.
        # TODO: Where to put this method? Wanted to extend this gem with vidius-user gem,
        # but that's not a good idea...
        def valid_oauth2_secret?(client_secret)
          client_secret == Vidibus::Secure.sign(uuid, secret)
        end

        protected

        # Sets an error if secret is given for Connector service.
        def dont_allow_secret_for_connector
          if connector? && secret
            errors.add(:secret, :secret_not_allowed_for_connector)
          end
        end

        def realm_required?
          !connector? && !this?
        end
      end

      module ClassMethods

        # Returns this service, if it has been configured, or raises an ConfigurationError.
        def this
          where(:this => true).and(:realm_uuid => nil).first or
            raise ConfigurationError.new("This service has not been configured yet. Use your Connector to set it up.")
        end

        # Returns Connector service, if it has been configured, or raises an ConfigurationError.
        def connector
          where(:function => "connector").and(:realm_uuid => nil).first or
            raise ConfigurationError.new("No Connector has been assigned to this service yet. Use your Connector to perform the assignment.")
        end

        # Returns best service by function or UUID within given realm.
        # If a service can be found in stored, it will be fetched from Connector.
        def discover(wanted, realm = nil)
          unless service = local(wanted, realm)
            service = remote(wanted, realm)
          end
          service
        end

        # Returns stored service by function or UUID within given realm.
        def local(wanted, realm = nil)
          key = Vidibus::Uuid.validate(wanted) ? :uuid : :function
          where(key => wanted).and(:realm_uuid => realm).first
        end

        # Requests service from Connector and stores it.
        # Wanted may be a function or an UUID.
        # This method should not be called directly. Use #discover to avoid unneccessary lookups.
        def remote(wanted, realm)
          unless realm
            raise ArgumentError.new("Please provide a valid realm to discover an appropriate service.")
          end
          if response = connector.client.get("/services/#{wanted}", :query => {:realm => realm})
            secret = response["secret"] || raise(ConnectorError.new("The Connector did not return a secret for #{wanted}. Response was: #{response.parsed_response.inspect}"))
            secret = Vidibus::Secure.decrypt(secret, this.secret)
            attributes = response.only(%w[uuid function url]).merge(:realm_uuid => realm, :secret => secret)
            create!(attributes)
          else
            raise "no service found"
          end
        end
      end
    end
  end
end

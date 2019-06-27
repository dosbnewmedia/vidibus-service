module Vidibus
  module Service
    module ControllerValidations
      extend ActiveSupport::Concern

      included do
        skip_before_action :verify_authenticity_token
        before_action :ensure_realm!
        before_action :ensure_service!
        before_action :validate_signature!
      end

      protected

      # Ensures that +realm+ parameter is given and valid.
      def ensure_realm!
        @realm = params[:realm] or raise "no realm given"
      end

      # Ensures that +service+ parameter is given and valid.
      def ensure_service!
        service = params[:service] or raise "no service given"
        @service = Service(service, @realm) or raise "invalid service"
      end

      # Validates +sign+ parameter.
      def validate_signature!
        params[:sign] or raise "no signature given"
        unless valid_request?(@service.secret)
          raise "invalid signature"
        end
      end
    end
  end
end

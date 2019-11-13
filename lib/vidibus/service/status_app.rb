module Vidibus
  module Service

    class StatusApp
      def self.call(env)
        self.new.call(env)
      end

      def call(env)
        [200, {"Content-Type" => "application/json"}, [{ pong: true }.to_json]]
      end
    end

  end
end

module Infusionsoft
  module Default
    REST_API_ENDPOINT = "https://api.infusionsoft.com/crm/rest/v1".freeze

    class << self
      def options
        Hash[Infusionsoft::Configurable.keys.map { |key| [key, send(key)] }]
      end

      def access_token
        ENV["INFUSIONSOFT_ACCESS_TOKEN"]
      end

      def login
        ENV["INFUSIONSOFT_LOGIN"]
      end

      def password
        ENV["INFUSIONSOFT_PASSWORD"]
      end

      def rest_api_endpoint
        ENV["INFUSIONSOFT_REST_API_ENDPOINT"] || REST_API_ENDPOINT
      end
    end
  end
end

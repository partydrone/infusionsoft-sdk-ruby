module Infusionsoft
  module Default
    REST_API_ENDPOINT = "https://api.infusionsoft.com/crm/rest/v1".freeze
    XMLRPC_API_ENDPOINT = "https://api.infusionsoft.com/crm/xmlrpc/v1".freeze

    class << self
      def options
        Hash[Infusionsoft::Configurable.keys.map { |key| [key, send(key)] }]
      end

      def access_token
        ENV["INFUSIONSOFT_ACCESS_TOKEN"]
      end

      def bearer_token
        ENV["INFUSIONSOFT_BEARER_TOKEN"]
      end

      def client_id
        ENV["INFUSIONSOFT_CLIENT_ID"]
      end

      def client_secret
        ENV["INFUSIONSOFT_CLIENT_SECRET"]
      end

      def login
        ENV["INFUSIONSOFT_LOGIN"]
      end

      def netrc
        ENV["INFUSIONSOFT_NETRC"] || false
      end

      def netrc_file
        ENV["INFUSIONSOFT_NETRC_FILE"] || File.join(ENV["HOME"].to_s, ".netrc")
      end

      def password
        ENV["INFUSIONSOFT_PASSWORD"]
      end

      def rest_api_endpoint
        ENV["INFUSIONSOFT_REST_API_ENDPOINT"] || REST_API_ENDPOINT
      end

      def xmlrpc_api_endpoint
        ENV["INFUSIONSOFT_XMLRPC_API_ENDPOINT"] || XMLRPC_API_ENDPOINT
      end
    end
  end
end

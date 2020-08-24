module Infusionsoft
  module Default
    BASE_URL = "https://api.infusionsoft.com/crm/rest/v1".freeze

    class << self
      def options
        Hash[Infusionsoft::Configurable.keys.map { |key| [key, send(key)] }]
      end

      def access_token
        ENV["INFUSIONSOFT_ACCESS_TOKEN"]
      end

      def base_url
        ENV["INFUSIONSOFT_BASE_URL"] || BASE_URL
      end
    end
  end
end

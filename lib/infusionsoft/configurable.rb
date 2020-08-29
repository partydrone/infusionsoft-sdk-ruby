module Infusionsoft
  module Configurable
    attr_accessor :access_token, :client_id, :client_secret
    attr_writer :login, :password, :rest_api_endpoint

    class << self
      def keys
        @keys ||= [
          :access_token,
          :login,
          :password,
          :rest_api_endpoint
        ]
      end
    end

    def configure
      yield self
    end

    def reset!
      Infusionsoft::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Infusionsoft::Default.options[key])
      end
      self
    end
    alias setup reset!

    def same_options?(opts)
      opts.hash == options.hash
    end

    def rest_api_endpoint
      File.join(@rest_api_endpoint, "")
    end

    def login
      @login = begin
        user.login
      end
    end

    private

    def options
      Hash[Infusionsoft::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end

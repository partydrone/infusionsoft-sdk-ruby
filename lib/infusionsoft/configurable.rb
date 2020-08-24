module Infusionsoft
  module Configurable
    attr_accessor :access_token
    attr_writer :base_url

    class << self
      def keys
        @keys ||= [
          :access_token,
          :base_url
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

    def base_url
      File.join(@base_url, "")
    end

    private

    def options
      Hash[Infusionsoft::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end

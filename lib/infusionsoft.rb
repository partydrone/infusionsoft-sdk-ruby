require "infusionsoft/client"
require "infusionsoft/default"
require "infusionsoft/version"

module Infusionsoft
  class << self
    include Infusionsoft::Configurable

    def client
      return @client if defined?(@client) && @client.same_options?(options)
      @client = Infusionsoft::Client.new(options)
    end

    private

    def respond_to_missing?(method_name, include_private=false)
      client.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      end

      super
    end
  end
end

# Infusionsoft.setup

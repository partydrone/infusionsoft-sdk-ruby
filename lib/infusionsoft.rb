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
  end
end

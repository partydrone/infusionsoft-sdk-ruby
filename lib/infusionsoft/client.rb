require "infusionsoft/configurable"

module Infusionsoft
  class Client
    include Infusionsoft::Configurable

    def initialize(options = {})
      Infusionsoft::Configurable.keys.each do |key|
        value = options.key?(key) ? options[key] : Infusionsoft.instance_variable_get(:"@#{key}")
        instance_variable_set(:"@#{key}", value)
      end
    end

    def login=(value)
      reset_agent
      @login = value
    end
  end
end

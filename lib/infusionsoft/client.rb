require "infusionsoft/warnable"
require "infusionsoft/configurable"
require "infusionsoft/authentication"

module Infusionsoft
  class Client
    include Infusionsoft::Authentication
    include Infusionsoft::Configurable
    include Infusionsoft::Warnable

    def initialize(options = {})
      Infusionsoft::Configurable.keys.each do |key|
        value = options.key?(key) ? options[key] : Infusionsoft.instance_variable_get(:"@#{key}")
        instance_variable_set(:"@#{key}", value)
      end

      login_from_netrc unless user_authenticated? || application_authenticated?
    end

    def inspect
      inspected = super

      inspected.gsub! @password, "********" if @password
      inspected.gsub! @access_token, "#{'*' * 36}#{@access_token[36..-1]}" if @access_token
      inspected.gsub! @bearer_token, "********" if @bearer_token
      inspected.gsub! @client_secret, "#{'*' * 36}#{@client_secret[36..-1]}" if @client_secret

      inspected
    end

    # def login=(value)
    #   # reset_agent
    #   @login = value
    # end

    # def password=(value)
    #   # reset_agent
    #   @password = value
    # end
  end
end

module Infusionsoft
  module Authentication
    def application_authenticated?
      !!(@client_id && @client_secret)
    end

    def bearer_authenticated?
      !!@bearer_token
    end

    def basic_authenticated?
      !!(@login && @password)
    end

    def token_authenticated?
      !!@access_token
    end

    def user_authenticated?
      !!(basic_authenticated? || token_authenticated?)
    end

    private

    def login_from_netrc
      return unless netrc?

      require "netrc"

      info = Netrc.read netrc_file
      netrc_host = URI.parse(rest_api_endpoint).host
      creds = info[netrc_host]

      if creds.nil?
        infusionsoft_warn "Error loading credentials from netrc file for #{rest_api_endpoint}."
      else
        creds = creds.to_a
        self.login = creds.shift
        self.password = creds.shift
      end
    rescue LoadError
      infusionsoft_warn "Please install netrc gem for .netrc support."
    end
  end
end

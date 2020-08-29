require "test_helper"

describe Infusionsoft::Client do
  before do
    Infusionsoft.reset!
  end

  after do
    Infusionsoft.reset!
  end

  describe "module configuration" do
    before do
      Infusionsoft.reset!
      Infusionsoft.configure do |config|
        Infusionsoft::Configurable.keys.each do |key|
          config.send("#{key}=", "Some #{key}")
        end
      end
    end

    after do
      Infusionsoft.reset!
    end

    it "inherits the configuration module" do
      client = Infusionsoft::Client.new
      Infusionsoft::Configurable.keys.each do |key|
        _(client.instance_variable_get(:"@#{key}")).must_equal "Some #{key}"
      end
    end

    describe "with class-level configuration" do
      before do
        @opts = {
          login: "defunkt",
          password: "il0veruby"
        }
      end

      it "overrides module configuration" do
        client = Infusionsoft::Client.new(@opts)

        _(client.login).must_equal "defunkt"
        _(client.instance_variable_get(:"@password")).must_equal "il0veruby"
        _(client.client_id).must_equal Infusionsoft.client_id
      end

      it "can set configuration after initialization" do
        client = Infusionsoft::Client.new

        client.configure do |config|
          @opts.each do |key, value|
            config.send("#{key}=", value)
          end
        end

        _(client.login).must_equal "defunkt"
        _(client.instance_variable_get(:"@password")).must_equal "il0veruby"
        _(client.client_id).must_equal Infusionsoft.client_id
      end

      it "masks passwords on inspect" do
        client    = Infusionsoft::Client.new(@opts)
        inspected = client.inspect

        _(inspected).wont_include "il0veruby"
      end

      it "masks access tokens on inspect" do
        client    = Infusionsoft::Client.new(access_token: "87614b09dd141c22800f96f11737ade5226d7ba8")
        inspected = client.inspect

        _(inspected).wont_include "87614b09dd141c22800f96f11737ade5226d7ba8"
      end

      it "masks bearer tokens on inspect" do
        client    = Infusionsoft::Client.new(bearer_token: "secret JWT")
        inspected = client.inspect

        _(inspected).wont_include "secret JWT"
      end

      it "masks client secrets on inspect" do
        client    = Infusionsoft::Client.new(client_secret: "87614b09dd141c22800f96f11737ade5226d7ba8")
        inspected = client.inspect

        _(inspected).wont_include "87614b09dd141c22800f96f11737ade5226d7ba8"
      end

      describe "with .netrc" do
        before do
          File.chmod(0600, File.join(fixture_path, ".netrc"))
        end

        it "can read .netrc files" do
          Infusionsoft.reset!
          client = Infusionsoft::Client.new(netrc: true, netrc_file: File.join(fixture_path, ".netrc"))

          _(client.login).must_equal "sferik"
          _(client.instance_variable_get(:"@password")).must_equal "il0veruby"
        end

        it "can read non-standard API endpoint creds from .netrc" do
          Infusionsoft.reset!
          client = Infusionsoft::Client.new(netrc: true, netrc_file: File.join(fixture_path, ".netrc"), rest_api_endpoint: "https://api.infusionsoft.dev")

          _(client.login).must_equal "defunkt"
          _(client.instance_variable_get(:"@password")).must_equal "il0veruby"
        end
      end
    end
  end

  describe "content type" do
    it "sets a default Content-Type header"
  end

  describe "authentication" do
    before do
      Infusionsoft.reset!
      @client = Infusionsoft.client
    end

    describe "with module-level config" do
      before do
        Infusionsoft.reset!
      end

      it "sets basic auth creds with .configure" do
        Infusionsoft.configure do |config|
          config.login    = "pengwyn"
          config.password = "il0veruby"
        end

        _(Infusionsoft.client).must_be :basic_authenticated?
      end

      it "sets basic auth creds with module methods" do
        Infusionsoft.login    = "pengwyn"
        Infusionsoft.password = "il0veruby"

        _(Infusionsoft.client).must_be :basic_authenticated?
      end

      it "sets OAuth token with .configure" do
        Infusionsoft.configure do |config|
          config.access_token = "d255197b4937b385eb63d1f4677e3ffee61fbaea"
        end

        _(Infusionsoft.client).wont_be :basic_authenticated?
        _(Infusionsoft.client).must_be :token_authenticated?
      end

      it "sets OAuth token with module method" do
        Infusionsoft.access_token = "d255197b4937b385eb63d1f4677e3ffee61fbaea"

        _(Infusionsoft.client).wont_be :basic_authenticated?
        _(Infusionsoft.client).must_be :token_authenticated?
      end

      it "sets bearer token with .configure" do
        Infusionsoft.configure do |config|
          config.bearer_token = "secret JWT"
        end

        _(Infusionsoft.client).wont_be :basic_authenticated?
        _(Infusionsoft.client).wont_be :token_authenticated?
        _(Infusionsoft.client).must_be :bearer_authenticated?
      end

      it "sets bearer token with module method" do
        Infusionsoft.bearer_token = "secret JWT"

        _(Infusionsoft.client).wont_be :basic_authenticated?
        _(Infusionsoft.client).wont_be :token_authenticated?
        _(Infusionsoft.client).must_be :bearer_authenticated?
      end

      it "sets OAuth application creds with .configure" do
        Infusionsoft.configure do |config|
          config.client_id     = "97b4937b385eb63d1f46"
          config.client_secret = "d255197b4937b385eb63d1f4677e3ffee61fbaea"
        end

        _(Infusionsoft.client).wont_be :basic_authenticated?
        _(Infusionsoft.client).wont_be :token_authenticated?
        _(Infusionsoft.client).must_be :application_authenticated?
      end

      it "sets OAuth application creds with module methods" do
        Infusionsoft.client_id     = "97b4937b385eb63d1f46"
        Infusionsoft.client_secret = "d255197b4937b385eb63d1f4677e3ffee61fbaea"

        _(Infusionsoft.client).wont_be :basic_authenticated?
        _(Infusionsoft.client).wont_be :token_authenticated?
        _(Infusionsoft.client).must_be :application_authenticated?
      end
    end

    describe "with class-level config" do
      it "sets basic auth creds with .configure" do
        @client.configure do |config|
          config.login    = "pengwyn"
          config.password = "il0veruby"
        end

        _(@client).must_be :basic_authenticated?
      end

      it "sets basic auth creds with instance methods" do
        @client.login    = "pengwyn"
        @client.password = "il0veruby"

        _(@client).must_be :basic_authenticated?
      end

      it "sets OAuth token with .configure" do
        @client.configure do |config|
          config.access_token = "d255197b4937b385eb63d1f4677e3ffee61fbaea"
        end

        _(@client).wont_be :basic_authenticated?
        _(@client).must_be :token_authenticated?
      end

      it "sets OAuth token with instance method" do
        @client.access_token = "d255197b4937b385eb63d1f4677e3ffee61fbaea"

        _(@client).wont_be :basic_authenticated?
        _(@client).must_be :token_authenticated?
      end

      it "sets OAuth application creds with .configure" do
        @client.configure do |config|
          config.client_id     = "97b4937b385eb63d1f46"
          config.client_secret = "d255197b4937b385eb63d1f4677e3ffee61fbaea"
        end

        _(@client).wont_be :basic_authenticated?
        _(@client).wont_be :token_authenticated?
        _(@client).must_be :application_authenticated?
      end

      it "sets OAuth application creds with instance methods" do
        @client.client_id     = "97b4937b385eb63d1f46"
        @client.client_secret = "d255197b4937b385eb63d1f4677e3ffee61fbaea"

        _(@client).wont_be :basic_authenticated?
        _(@client).wont_be :token_authenticated?
        _(@client).must_be :application_authenticated?
      end
    end

    describe "when basic authenticated" do
      it "makes authenticated calls" do
        Infusionsoft.configure do |config|
          config.login    = "pengwyn"
          config.password = "il0veruby"
        end

        root_request = stub_request(:get, infusionsoft_url("/")).with(basic_auth: ["pengwyn", "il0veruby"])

        Infusionsoft.client.get("/")
        assert_requested root_request
      end
    end
  end
end

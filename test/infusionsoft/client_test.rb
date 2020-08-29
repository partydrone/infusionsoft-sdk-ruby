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
        _(client.instance_variable_get(:"@#{password}")).must_equal "il0veruby"
        _(client.client_id).must_equal Infusionsoft.client_id
      end
    end
  end
end

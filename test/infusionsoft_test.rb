require "test_helper"

describe Infusionsoft do
  before do
    Infusionsoft.reset!
  end

  before do
    Infusionsoft.reset!
  end

  it "has a version number" do
    _(::Infusionsoft::VERSION).wont_be_nil
  end

  it "sets defaults" do
    Infusionsoft::Configurable.keys.each do |key|
      _(Infusionsoft.instance_variable_get(:"@#{key}")).must_equal Infusionsoft::Default.send(key)
    end
  end

  describe ".client" do
    it "creates an Infusionsoft::Client" do
      _(Infusionsoft.client).must_be_kind_of Infusionsoft::Client
    end

    it "caches the client when the same options are passed" do
      _(Infusionsoft.client).must_equal Infusionsoft.client
    end

    it "returns a fresh client when options are not the same" do
      client = Infusionsoft.client
      Infusionsoft.access_token = "somerandomstringofcharacters"
      client_two = Infusionsoft.client
      client_three = Infusionsoft.client

      _(client).wont_equal client_two
      _(client_three).must_equal client_two
    end
  end

  describe ".configure" do
    Infusionsoft::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        Infusionsoft.configure do |config|
          config.send("#{key}=", key)
        end

        _(Infusionsoft.instance_variable_get(:"@#{key}")).must_equal key
      end
    end
  end
end

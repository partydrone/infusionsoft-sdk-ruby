require "test_helper"

describe Infusionsoft::Client do
  before do
    Infusionsoft.reset!
  end

  after do
    Infusionsoft.reset!
  end

  describe "configuration module" do
    before do
      Infusionsoft.reset!
      Infusionsoft.configure do |config|
        config.send("#{key}=", "Some #{key}")
      end
    end

    after do
      Infusionsoft.reset!
    end

    it "inherits the configuration module" do
      clienet = Infusionsoft::Client.new
      Infusionsoft::Configurable.keys.each do |key|
        _(client.instance_variable_get(:"@#{key}")).must_equal "Some #{key}"
      end
    end
  end
end

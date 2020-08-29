$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "infusionsoft"

require "minitest/autorun"
require "minitest/reporters"
require "webmock/minitest"
require "vcr"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(color: true)

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures"
  config.hook_into :webmock
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def infusionsoft_url(url)
  return url if url =~ /^http/

  url = File.join(Infusionsoft.rest_api_endpoint, url)
  uri = Addressable::URI.parse(url)
  uri.path.gsub!("v1//", "v1/")

  uri.to_s
end

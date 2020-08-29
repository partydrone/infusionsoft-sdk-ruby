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

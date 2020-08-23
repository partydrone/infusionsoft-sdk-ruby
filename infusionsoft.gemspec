require_relative 'lib/infusionsoft/version'

Gem::Specification.new do |spec|
  spec.name          = "infusionsoft"
  spec.version       = Infusionsoft::VERSION
  spec.authors       = ["Andrew Porter"]
  spec.email         = ["partydrone@icloud.com"]

  spec.summary       = %q{Ruby SDK for the Infusionsoft API.}
  spec.description   = %q{Ruby SDK for the Infusionsoft API.}
  spec.homepage      = "https://github.com/partydrone/infusionsoft-sdk-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/partydrone/infusionsoft-sdk-ruby.git"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "faraday"
  spec.add_dependency "oj"
end

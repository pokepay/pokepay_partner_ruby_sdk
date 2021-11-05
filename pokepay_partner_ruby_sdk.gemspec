lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pokepay_partner_ruby_sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "pokepay_partner_ruby_sdk"
  spec.version       = Pokepay::VERSION
  spec.authors       = ["Pocket Change, Inc."]
  spec.email         = ["contact@pocket-change.jp"]

  spec.summary       = %q{Pokepay Partner API SDK for Ruby}
  spec.description   = %q{Pokepay Partner API SDK for Ruby}
  spec.homepage      = "https://github.com/pokepay/pokepay_partner_ruby_sdk"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pokepay/pokepay_partner_ruby_sdk"
  spec.metadata["changelog_uri"] = "https://github.com/pokepay/pokepay_partner_ruby_sdk"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "openssl", "~> 2.1.2"
  spec.add_dependency "json", "~> 2.3.0"
  spec.add_dependency "inifile", "~> 3.0.0"
end

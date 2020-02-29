
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "keytechKit/version"

Gem::Specification.new do |spec|
  spec.name          = "keytechkit"
  spec.version       = KeytechKit::VERSION
  spec.author        = "Thorsten Claus"
  spec.email         = ["thorstenclaus@web.de"]
  spec.summary       = "keytechkit is a ruby gem to connect to the keytech Web API"
  spec.homepage      = "https://claus-software.de"
  spec.license       = "MIT"
  spec.metadata      = { "source_code_uri" => "https://github.com/tclaus/keytechkit.gem" }
  spec.required_ruby_version     = ">= 2.4.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rails", "~> 5.2"
       
  spec.add_dependency "httparty", "~> 0.16"
end

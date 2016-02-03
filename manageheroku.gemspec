# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manageheroku/version'

Gem::Specification.new do |spec|
  spec.name          = "manageheroku"
  spec.version       = Manageheroku::VERSION
  spec.authors       = ["Josh Cronemeyer"]
  spec.email         = ["joshuacronemeyer@gmail.com"]
  spec.summary       = %q{Manage Heroku Apps from config files}
  spec.description   = %q{Manage Heroku Apps from config files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'platform-api', '~> 0.5.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

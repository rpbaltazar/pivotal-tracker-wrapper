# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pivotal/tracker/wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "pivotal-tracker-wrapper"
  spec.version       = Pivotal::Tracker::Wrapper::VERSION
  spec.authors       = ["Rui Baltazar"]
  spec.email         = ["rui.p.baltazar@gmail.com"]
  spec.summary       = %q{Pivotal Tracker API wrapper}
  spec.description   = %q{This gem is intended to cover the lack of a Pivotal Tracker ruby wrapper for the v5 endpoints}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

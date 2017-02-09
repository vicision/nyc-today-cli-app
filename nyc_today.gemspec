# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nyc_today/version'

Gem::Specification.new do |spec|
  spec.name          = "nyc_today"
  spec.version       = NycToday::VERSION
  spec.authors       = ["Duncan McLachlan"]
  spec.email         = ["duncanjmclachlan@gmail.com"]

  spec.summary       = %q{CLI that lists and provides information about today's events in and around NYC.}
  spec.description   = %q{This CLI app lists a set of event categories in and around New York City for users to select from, displays a list of events and their details from that chosen type and displays further information (if available) about any chosen event.}
  spec.homepage      = "https://github.com/vicision/nyc-today-cli-app"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.3.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   << "nyc_today"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0"
  spec.add_runtime_dependency "nokogiri"
end

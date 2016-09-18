# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/droidicon/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-droidicon'
  spec.version       = Fastlane::Droidicon::VERSION
  spec.author        = %q{@chrhsmt}
  spec.email         = %q{chr@chrhsmt.com}

  spec.summary       = %q{Generate required icon sizes and iconset from a master application icon}
  spec.homepage      = "https://github.com/chrhsmt/fastlane-plugin-droidicon"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mini_magick', '~> 4.5.1'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.101.0'
end

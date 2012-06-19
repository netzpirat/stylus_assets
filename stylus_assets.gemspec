# coding: UTF-8
require File.expand_path('../lib/stylus_assets/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'stylus_assets'
  s.version     = StylusAssets::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Michael Kessler']
  s.email       = ['michi@netzpiraten.ch']
  s.homepage    = 'https://github.com/netzpirat/stylus_assets'
  s.summary     = 'Stylus JavaScript Templates'
  s.description = 'Stylus JavaScript Templates in the asset pipeline.'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'stylus_assets'

  s.files         = Dir.glob('{app,lib,vendor}/**/*') + %w[LICENSE README.md]

  s.add_runtime_dependency 'tilt', '>= 1.3.3'
  s.add_runtime_dependency 'sprockets', '>= 2.0.3'

  s.add_development_dependency 'bundler'
end

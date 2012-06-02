# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'guard/sprockets/version'

Gem::Specification.new do |s|
  s.name        = 'guard-sprockets'
  s.version     = Guard::SprocketsVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Aaron Cruz', 'Kematzy']
  s.email       = ['aaron@aaroncruz.com', 'kematzy at gmail']
  s.homepage    = 'https://rubygems.org/gems/guard-sprockets'
  s.summary     = 'Guard gem for Sprockets'
  s.description = 'Guard::Sprockets automatically packages your javascript files together.'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = 'guard-sprockets'

  s.add_dependency 'guard',     '>= 1.1.0.beta'
  s.add_dependency 'sprockets', '~> 2.0'

  s.add_development_dependency 'bundler', '~> 1.1'
  s.add_development_dependency 'rspec',   '~> 2.10'

  s.files        = Dir.glob('{lib}/**/*') + %w[README.md]
  s.require_path = 'lib'
end

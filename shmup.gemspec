# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'shmup/version'

Gem::Specification.new do |spec|
  spec.name          = 'Shmup'
  spec.version       = Shmup::VERSION
  spec.authors       = ['Michał Szota']
  spec.email         = ['mic.szota@gmail.com']

  spec.homepage      = 'https://tba.tba'
  spec.summary       = "A work-in-progress Shoot'em up game written in Ruby using gosu."
  spec.description   = "A work-in-progress Shoot'em up game written in Ruby using gosu."
  spec.license       = 'MIT'
  spec.files        = Dir['{lib/**/*,[A-Z]*}']

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.3'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
  spec.add_development_dependency 'logger'

  spec.add_dependency 'gosu'
end

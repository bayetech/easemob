# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easemob/version'

Gem::Specification.new do |spec|
  spec.name          = 'easemob'
  spec.version       = Easemob::VERSION
  spec.authors       = ['Eric Guo']
  spec.email         = ['eric.guocz@gmail.com']

  spec.summary       = 'An unofficial Easemob IM(instant message) service integration gem'
  spec.description   = 'Helping rubyist integration with Easemob IM service (环信 - 即时通讯云) easier.'
  spec.homepage      = 'https://github.com/bayetech/easemob'
  spec.license       = 'MIT'
  spec.required_ruby_version = '~> 2.2'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end - %w(CODE_OF_CONDUCT.md easemob.sublime-project Gemfile Rakefile easemob.gemspec bin/setup bin/console)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'http', '>= 2.0.3', '< 3'
  spec.add_runtime_dependency 'connection_pool', '>= 2.2', '< 3'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 11.3'
  spec.add_development_dependency 'rspec', '~> 3.5'
end

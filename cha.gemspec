# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cha/version'

Gem::Specification.new do |spec|
  spec.name          = 'cha'
  spec.version       = Cha::VERSION
  spec.authors       = ['Kazuya Takeshima']
  spec.email         = ['mail@mitukiii.jp']
  spec.summary       = %q{A Ruby wrapper for the ChatWork API}
  spec.homepage      = 'http://github.com/mitukiii/cha'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 0.11.0'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.11.0'
  spec.add_runtime_dependency 'multi_json', '~> 1.12.1'
  spec.add_runtime_dependency 'hashie', '~> 3.5.1'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'yard'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phase_shift/version'

Gem::Specification.new do |spec|
  spec.name          = 'phase_shift'
  spec.version       = PhaseShift::VERSION
  spec.authors       = ['Jurgens du Toit']
  spec.email         = ['jrgns@jadeit.co.za']
  spec.description   = spec.summary
  spec.summary       = 'A simple pipeline processing implementation'
  spec.homepage      = 'https://github.com/hackerplanet/phase_shift'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
end

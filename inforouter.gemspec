lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inforouter/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'nokogiri', '~> 1.5.9'
  spec.add_dependency 'savon', '~> 2.4.0'
  spec.authors = ['Tom Fenton']
  spec.description = %q(A Ruby interface to the infoRouter SOAP API.)
  spec.email = %w[tom@ncs.co.nz]
  spec.files = %w[LICENSE.md README.md Rakefile inforouter.gemspec]
  spec.files += Dir.glob('lib/**/*.rb')
  spec.files += Dir.glob('spec/**/*')
  # spec.homepage = 'http://ncssoftware.github.com/inforouter'
  spec.licenses = %w[MIT]
  spec.name = 'inforouter'
  spec.require_paths = %w[lib]
  spec.required_rubygems_version = '>= 1.3.5'
  spec.summary = spec.description
  spec.test_files = Dir.glob('spec/**/*')
  spec.version = Inforouter::Version
 end

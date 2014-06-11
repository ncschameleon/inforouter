# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inforouter/version'

Gem::Specification.new do |spec|
  spec.name          = "inforouter"
  spec.version       = Inforouter::Version
  spec.authors       = ["Tom Fenton"]
  spec.email         = ["tom@ncs.co.nz"]
  spec.description   = %q(A Ruby interface to the infoRouter SOAP API.)
  spec.summary       = spec.description
  # spec.homepage      = "http://ncssoftware.github.com/inforouter"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.5.9"
  spec.add_dependency "savon", "~> 2.4.0"
 end
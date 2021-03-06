# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hac_adapter/version'

Gem::Specification.new do |spec|
  spec.name          = 'hac_adapter'
  spec.version       = HacAdapter::VERSION
  spec.authors       = ['Josh Burks']
  spec.email         = ['dotnofoolin@gmail.com']

  spec.summary       = 'HAC Adapter scrapes grades from the interface your school provides (Home Access Center) for keeping track of your kids grades.'
  spec.homepage      = 'https://github.com/dotnofoolin/hac_adapter'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to "http://mygemserver.com"'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'

  spec.add_runtime_dependency 'mechanize'
  spec.add_runtime_dependency 'terminal-table'
end

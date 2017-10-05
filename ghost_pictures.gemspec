
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ghost_pictures/version'

Gem::Specification.new do |spec|
  spec.name          = 'ghost_pictures'
  spec.version       = GhostPictures::VERSION
  spec.authors       = ['sinsoku']
  spec.email         = ['sinsoku.listy@gmail.com']

  spec.summary       = 'GhostPictures provides the feature to wait for Ajax requests with Capybara.'
  spec.description   = 'GhostPictures provides the feature to wait for Ajax requests with Capybara.'
  spec.homepage      = 'https://github.com/sinsoku/ghost_pictures'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'rubocop'
end

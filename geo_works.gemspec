# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geo_works/version'

Gem::Specification.new do |spec|
  spec.name          = 'geo_works'
  spec.version       = GeoWorks::VERSION
  spec.authors       = [ 'James Griffin', 'Darren Hardy', 'John Huck', 'Eric James', 'Eliot Jordan' ]
  spec.email         = ['jrgriffiniii@gmail.com', 'drh@stanford.edu', 'jhuck@ualberta.ca', 'eric.james@yale.edu', 'eliotj@princeton.edu']
  spec.summary       = %q{Rails engine for Hydra Geo models. Built around the Hyrax engine. }
  spec.description   = %q{Rails engine for Hydra Geo models. Built around the Hyrax engine. }
  spec.homepage      = 'https://github.com/samvera-labs/geo_works'
  spec.license       = 'APACHE2'

  spec.files = `git ls-files | grep -v ^spec/fixtures`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.2' # same as Rails 5

  spec.add_dependency 'hyrax', '~> 2.0.2'
  spec.add_dependency 'leaflet-rails', '~> 0.7'
  spec.add_dependency 'json-schema', '>= 2.6.2'
  spec.add_dependency 'rgeoserver', '>= 0.10.0'
  spec.add_dependency 'simpler-tiles'
  spec.add_dependency 'jquery-ui-rails', '~> 5.0.5'

  ########################################################
  # Temporarily pinned dependencies. INCLUDE EXPLANATIONS.
  #
  # simple_form 3.5.1 broke hydra-editor for certain model types;
  #   see: https://github.com/plataformatec/simple_form/issues/1549
  #   and: https://github.com/samvera/hyrax/issues/2675

  spec.add_dependency 'simple_form', '~> 3.2', '<= 3.5.0'

  ########################################################

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'devise', '>= 3.0', '< 5'
  spec.add_development_dependency 'rspec-rails', '>= 3.5.2'
  spec.add_development_dependency 'engine_cart', '~> 1.0', '>= 1.0.1'
  spec.add_development_dependency 'solr_wrapper', '~> 0.18', '>= 0.18.0'
  spec.add_development_dependency 'fcrepo_wrapper', '~> 0.6', '>= 0.6.0'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'database_cleaner', '< 1.1.0'
  spec.add_development_dependency 'rubocop', '~> 0.39'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.4.1'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'capybara', '~> 2.7'
  spec.add_development_dependency "poltergeist", "~> 1.5"
end

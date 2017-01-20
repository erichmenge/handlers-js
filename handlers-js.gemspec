# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "handlers-js"
  gem.version       = "0.0.2"
  gem.authors       = ["Erich Menge"]
  gem.email         = ["erich.menge@me.com"]
  gem.description   = %q{Easy, modular UJS for your Rails apps}
  gem.summary       = %q{Easy, modular UJS for your Rails apps}
  gem.homepage      = "https://github.com/erichmenge/handlers-js"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency('rake')
  gem.add_development_dependency('jasmine')
end

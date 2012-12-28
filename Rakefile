require "bundler/gem_tasks"

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end

task :build_js do
  `coffee -o src -c lib/assets/javascripts/handlers.coffee`
  `coffee -c spec/javascripts`
end

task :default => [:build_js, 'jasmine:ci']

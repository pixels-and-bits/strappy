# use this for local installs
SOURCE=ENV['LOCAL'] || 'http://github.com/pixels-and-bits/strappy/raw/master'

# Git
file '.gitignore', open("#{SOURCE}/gitignore").read
git :init
git :add => '.gitignore'
run 'rm -f public/images/rails.png'
run 'cp config/database.yml config/database.template.yml'
git :add => "."
git :commit => "-a -m 'Initial commit'"

# Haml, doing this before gemtools install since we are using 2.1
inside('tmp') do
  run 'rm -rf ./haml' if File.exist?('haml')
  run 'git clone git://github.com/nex3/haml.git'
end

inside('tmp/haml') do
  run 'rake install'
end

run 'echo N\n | haml --rails .'
run 'mkdir -p public/stylesheets/sass'
%w( main reset ).each do |file|
  file "public/stylesheets/sass/#{file}.sass",
    open("#{SOURCE}/#{file}.sass").read
end
git :add => "."
git :commit => "-a -m 'Added Haml and Sass stylesheets'"

# GemTools
file 'config/gems.yml', open("#{SOURCE}/gems.yml").read
run 'sudo gem install gem_tools --no-rdoc --no-ri'
run 'sudo gemtools install'
initializer 'gem_tools.rb', "require 'gem_tools'\nGemTools.load_gems"
git :add => "."
git :commit => "-a -m 'Added GemTools config'"

# CoreExtensions
# plugin 'core_extensions',
#   :git => 'git@github.com:UnderpantsGnome/core_extensions.git'
# git :add => "."
# git :commit => "-a -m 'Added Core Extensions'"

# Application Layout
file 'app/views/layouts/application.html.haml',
  open("#{SOURCE}/application.html.haml").read
git :add => "."
git :commit => "-a -m 'Added Layout'"

# install strappy rake tasks
rakefile 'strappy.rake', open("#{SOURCE}/strappy.rake").read

# RSpec
generate 'rspec'
file 'spec/rcov.opts', open("#{SOURCE}/rcov.opts").read
git :add => "."
git :commit => "-a -m 'Added RSpec'"

# SiteConfig
file 'config/site.yml', open("#{SOURCE}/site.yml").read
lib 'site_config.rb', open("#{SOURCE}/site_config.rb").read
git :add => "."
git :commit => "-a -m 'Added SiteConfig'"

# CC.rb
rakefile('cruise.rake') { open("#{SOURCE}/cruise.rake").read }
git :add => "."
git :commit => "-a -m 'Added cruise rake task'"

# Capistrano
capify!
file 'config/deploy.rb', open("#{SOURCE}/deploy.rb").read

%w( production staging ).each do |env|
  file "config/deploy/#{env}.rb", "set :rails_env, \"#{env}\""
end
git :add => "."
git :commit => "-a -m 'Added Capistrano config'"

# Setup AR Sessions
rake('db:sessions:create')
rake('db:migrate')
git :add => "."
git :commit => "-a -m 'Added AR Sessions'"

# RESTful Auth
inside('vendor/plugins') do
  run 'rm -rf restful_authentication' if File.exist?('restful_authentication')
  run 'rm -rf restful-authentication' if File.exist?('restful-authentication')
end

plugin 'restful_authentication',
  :git => 'git://github.com/UnderpantsGnome/restful_authentication.git'

run './script/generate authenticated user session \
--include-activation \
--aasm \
--rspec'

# add in the user_observer
environment 'config.active_record.observers = :user_observer'

# for some reason rails complains about AASM unless we have this
gem 'rubyist-aasm', :lib => 'aasm', :source => 'http://gems.github.com'

# Sassify the templates
inside('app/views/users/') do
  run 'html2haml -r new.html.erb new.html.haml && rm new.html.erb'
  # no idea what this file is...
  run 'rm _user_bar.html.erb' if File.exist?('_user_bar.html.erb')
end

inside('app/views/sessions/') do
  run 'html2haml -r new.html.erb new.html.haml && rm new.html.erb'
end

# add routes
route open("#{SOURCE}/restful_auth_routes.rb").read

rake('db:migrate')
git :add => "."
git :commit => "-a -m 'Added RESTful Authentication'"

# jRails
plugin 'jrails', :svn => 'http://ennerchi.googlecode.com/svn/trunk/plugins/jrails'

# remove the installed files, we're using a newer version below
inside('public/javascripts') do
  %w( jquery-ui.js jquery.js ).each do |file|
    run "rm -f #{file}"
  end
end

git :add => "."
git :commit => "-a -m 'Added jRails plugin'"

# jQuery
git :rm => "public/javascripts/*"

file 'public/javascripts/jquery.js',
  open('http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js').read
file 'public/javascripts/jquery.full.js',
  open('http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.js').read
file 'public/javascripts/jquery-ui.js',
  open('http://ajax.googleapis.com/ajax/libs/jqueryui/1.5/jquery-ui.min.js').read
file 'public/javascripts/jquery-ui.full.js',
  open('http://ajax.googleapis.com/ajax/libs/jqueryui/1.5/jquery-ui.js').read
file 'public/javascripts/jquery.form.js',
  open('http://jqueryjs.googlecode.com/svn/trunk/plugins/form/jquery.form.js').read

file "public/javascripts/application.js", <<-JS
$(function() {
  // ...
});
JS

git :add => "."
git :commit => "-a -m 'Added jQuery with UI and form plugin'"

# Blackbird
run 'mkdir -p public/blackbird'
inside('public/blackbird') do
  file 'public/blackbird/blackbird.js',
    open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.js').read
  file 'public/blackbird/blackbird.css',
    open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.css').read
  file 'public/blackbird/blackbird.png',
    open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.png').read
end
git :add => "."
git :commit => "-a -m 'Added Blackbird'"

# Add ApplicationHelper
file 'app/helpers/application_helper.rb',
  open("#{SOURCE}/application_helper.rb").read
git :add => "."
git :commit => "-a -m 'Added ApplicationHelper'"

# Add ApplicationController
file 'app/controllers/application_controller.rb',
  open("#{SOURCE}/application_controller.rb").read
git :add => "."
git :commit => "-a -m 'Added ApplicationController'"

# Remove index.html and add HomeController
git :rm => 'public/index.html'
generate :rspec_controller, 'home'
route "map.root :controller => 'home'"
file 'app/views/home/index.html.haml', '%h1 Welcome'
git :add => "."
git :commit => "-a -m 'Removed index.html. Added HomeController'"

puts "\n#{'*' * 80}\n\n"
puts "Be sure to clean up the views converted to Haml (fix indenting, remove - end)"
puts "  app/views/sessions/new.html.haml"
puts "  app/views/users/new.html.haml"
puts "\n#{'*' * 80}\n\n"

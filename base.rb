# use this for local installs
SOURCE=ENV['LOCAL'] || 'http://github.com/pixels-and-bits/strappy/raw/authlogic'

# Git
file '.gitignore', open("#{SOURCE}/gitignore").read
git :init
git :add => '.gitignore'
run 'rm -f public/images/rails.png'
run 'cp config/database.yml config/database.template.yml'
git :add => "."
git :commit => "-a -m 'Initial commit'"

# Haml, doing this before gemtools install since we are using 2.1
unless File.exist?('tmp/haml')
  inside('tmp') do
    run 'rm -rf ./haml' if File.exist?('haml')
    run 'git clone git://github.com/nex3/haml.git'
  end
end

inside('tmp/haml') do
  run 'rake install'
end

run 'echo N\n | haml --rails .'
run 'mkdir -p public/stylesheets/sass'
%w( main reset ).each do |file|
  file "public/stylesheets/sass/#{file}.sass",
    open("#{SOURCE}/public/stylesheets/sass/#{file}.sass").read
end
git :add => "."
git :commit => "-a -m 'Added Haml and Sass stylesheets'"

# GemTools
file 'config/gems.yml', open("#{SOURCE}/config/gems.yml").read
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
  open("#{SOURCE}/app/views/layouts/application.html.haml").read
git :add => "."
git :commit => "-a -m 'Added Layout'"

# install strappy rake tasks
rakefile 'strappy.rake', open("#{SOURCE}/lib/tasks/strappy.rake").read

# RSpec
generate 'rspec'
file 'spec/rcov.opts', open("#{SOURCE}/spec/rcov.opts").read
git :add => "."
git :commit => "-a -m 'Added RSpec'"

# SiteConfig
file 'config/site.yml', open("#{SOURCE}/config/site.yml").read
lib 'site_config.rb', open("#{SOURCE}/lib/site_config.rb").read
git :add => "."
git :commit => "-a -m 'Added SiteConfig'"

# CC.rb
rakefile('cruise.rake') { open("#{SOURCE}/lib/tasks/cruise.rake").read }
git :add => "."
git :commit => "-a -m 'Added cruise rake task'"

# Capistrano
capify!
file 'config/deploy.rb', open("#{SOURCE}/config/deploy.rb").read

%w( production staging ).each do |env|
  file "config/deploy/#{env}.rb", "set :rails_env, \"#{env}\""
end
git :add => "."
git :commit => "-a -m 'Added Capistrano config'"

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
  open("#{SOURCE}/app/helpers/application_helper.rb").read
git :add => "."
git :commit => "-a -m 'Added ApplicationHelper'"

# Add ApplicationController
file 'app/controllers/application_controller.rb',
  open("#{SOURCE}/app/controllers/application_controller.rb").read
git :add => "."
git :commit => "-a -m 'Added ApplicationController'"

# Remove index.html and add HomeController
git :rm => 'public/index.html'
generate :rspec_controller, 'home'
route "map.root :controller => 'home'"
file 'app/views/home/index.html.haml', '%h1 Welcome'
git :add => "."
git :commit => "-a -m 'Removed index.html. Added HomeController'"

# Setup Authlogic
# rails gets cranky when this isn't included in the config
gem 'authlogic'
generate 'session user_session'
generate 'rspec_controller user_sessions'
generate 'scaffold user login:string \
  crypted_password:string \
  password_salt:string \
  persistence_token:string \
  login_count:integer \
  last_request_at:datetime \
  last_login_at:datetime \
  current_login_at:datetime \
  last_login_ip:string \
  current_login_ip:string'

# get rid of the generated templates
Dir.glob('app/views/users/*.erb').each do |file|
  run "rm #{file}"
end
run "rm app/views/layouts/users.html.erb"

generate 'controller password_reset'

route "map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'"
route "map.login '/login', :controller => 'user_sessions', :action => 'new'"
route "map.signup '/signup', :controller => 'users', :action => 'new'"
route 'map.resource :user_session'
route 'map.resource :account, :controller => "users"'
route 'map.resources :password_reset'

# migrations
file Dir.glob('db/migrate/*_create_users.rb').first,
  open("#{SOURCE}/db/migrate/create_users.rb").read

# models
%w( user notifier ).each do |name|
  file "app/models/#{name}.rb",
    open("#{SOURCE}/app/models/#{name}.rb").read
end

# controllers
%w( user_sessions password_reset users ).each do |name|
  file "app/controllers/#{name}_controller.rb",
    open("#{SOURCE}/app/controllers/#{name}_controller.rb").read
end

# views
%w(
  notifier/password_reset_instructions.erb
  password_reset/edit.html.haml
  password_reset/new.html.haml
  user_sessions/new.html.haml
  users/_form.haml
  users/edit.html.haml
  users/new.html.haml
  users/show.html.haml
).each do |name|
  file "app/views/#{name}", open("#{SOURCE}/app/views/#{name}").read
end

# testing goodies
gsub_file 'spec/spec_helper.rb', /(#{Regexp.escape("require 'spec/rails'")})/mi do |match|
  <<-EOM
#{match}
require 'authlogic/testing/test_unit_helpers'
  EOM
end

# specs
run 'mkdir -p spec/fixtures'

%w(
  fixtures/users.yml
  controllers/application_controller_spec.rb
  controllers/home_controller_spec.rb
  controllers/password_reset_controller_spec.rb
  controllers/user_sessions_controller_spec.rb
  controllers/users_controller_spec.rb
  views/home/index.html.haml_spec.rb
).each do |name|
  file "spec/#{name}", open("#{SOURCE}/spec/#{name}").read
end

rake('db:migrate')
git :add => "."
git :commit => "-a -m 'Added Authlogic'"

puts "\n#{'*' * 80}\n\n"
puts "All done. Enjoy."
puts "\n#{'*' * 80}\n\n"

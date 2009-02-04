# use this for local installs
SOURCE='/Users/mmoen/tmp/rails_templates/template'

# puts SOURCE

# Git
file '.gitignore', open("#{SOURCE}/gitignore").read
git :init
git :add => '.gitignore'
git :add => "."
git :rm => 'public/images/rails.png -f'
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
%w( main reset ).each do |env|
  file "public/stylesheets/sass/#{env}.sass",
    open("#{SOURCE}/#{env}.sass")
end
git :add => "."
git :commit => "-a -m 'Added Haml and Sass stylesheets'"

# GemTools
file 'config/gems.yml', open("#{SOURCE}/gems.yml").read
run 'sudo gem install gem_tools --no-rdoc --no-ri'
run 'sudo gemtools install'
git :add => "."
git :commit => "-a -m 'Added GemTools config'"

# Application Layout
file 'app/views/layouts/application.html.haml',
  open("#{SOURCE}/application.html.haml").read
git :add => "."
git :commit => "-a -m 'Added Layout'"

# RSpec
generate 'rspec'
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
run 'capify .'
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
  :git => 'git://github.com/technoweenie/restful-authentication.git'

inside('vendor/plugins') do
  run 'mv ./restful-authentication ./restful_authentication'
end

# for some reason rails complains about AASM unless we have this
gem 'rubyist-aasm', :lib => 'aasm', :source => 'http://gems.github.com'

run './script/generate authenticated user sessions \
  --include-activation \
  --aasm \
  --rspec'

# Sassify the templates
inside('app/views/users/') do
  run 'html2haml -r new.html.erb new.html.haml && rm new.html.erb'
end

inside('app/views/sessions/') do
  run 'html2haml -r new.html.erb new.html.haml && rm new.html.erb'
end

rake('db:migrate')
git :add => "."
git :commit => "-a -m 'Added RESTful Authentication'"

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

# jRails
plugin 'jrails', :svn => 'http://ennerchi.googlecode.com/svn/trunk/plugins/jrails'
git :add => "."
git :commit => "-a -m 'Added jRails plugin'"

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
inside('app/helpers') do
  file 'application_helper.rb', open("#{SOURCE}/application_helper.rb").read
end
git :add => "."
git :commit => "-a -m 'Added ApplicationHelper'"

# Add ApplicationController
inside('app/controllers') do
  file 'application_controller.rb',
    open("#{SOURCE}/application_controller.rb").read
end
git :add => "."
git :commit => "-a -m 'Added ApplicationController'"

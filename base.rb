# use this for local installs
SOURCE=ENV['LOCAL'] || 'http://github.com/pixels-and-bits/strappy/raw/choosy'

def file_append(file, data)
  File.open(file, 'a') {|f| f.write(data) }
end

def file_inject(file_name, sentinel, string, before_after=:after)
  gsub_file file_name, /(#{Regexp.escape(sentinel)})/mi do |match|
    if :after == before_after
      "#{match}\n#{string}"
    else
      "#{string}\n#{match}"
    end
  end
end

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
    open("#{SOURCE}/common/public/stylesheets/sass/#{file}.sass").read
end
git :add => "."
git :commit => "-a -m 'Added Haml and Sass stylesheets'"

# GemTools
file 'config/gems.yml', open("#{SOURCE}/common/config/gems.yml").read
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

# install strappy rake tasks
rakefile 'strappy.rake', open("#{SOURCE}/common/lib/tasks/strappy.rake").read

# RSpec
generate 'rspec'
file 'spec/rcov.opts', open("#{SOURCE}/common/spec/rcov.opts").read
git :add => "."
git :commit => "-a -m 'Added RSpec'"

# SiteConfig
file 'config/site.yml', open("#{SOURCE}/common/config/site.yml").read
lib 'site_config.rb', open("#{SOURCE}/common/lib/site_config.rb").read
git :add => "."
git :commit => "-a -m 'Added SiteConfig'"

# CC.rb
rakefile('cruise.rake') { open("#{SOURCE}/common/lib/tasks/cruise.rake").read }
git :add => "."
git :commit => "-a -m 'Added cruise rake task'"

# Capistrano
capify!
file 'config/deploy.rb', open("#{SOURCE}/common/config/deploy.rb").read

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
file 'public/blackbird/blackbird.js',
  open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.js').read
file 'public/blackbird/blackbird.css',
  open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.css').read
file 'public/blackbird/blackbird.png',
  open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.png').read

git :add => "."
git :commit => "-a -m 'Added Blackbird'"

# Add ApplicationHelper
file 'app/helpers/application_helper.rb',
  open("#{SOURCE}/common/app/helpers/application_helper.rb").read
git :add => "."
git :commit => "-a -m 'Added ApplicationHelper'"

# Remove index.html and add HomeController
git :rm => 'public/index.html'
generate :rspec_controller, 'home'
route "map.root :controller => 'home'"
file 'app/views/home/index.html.haml', '%h1 Welcome'
file "spec/views/home/index.html.haml_spec.rb",
  open("#{SOURCE}/common/spec/views/home/index.html.haml_spec.rb").read
file "spec/controllers/home_controller_spec.rb",
  open("#{SOURCE}/common/spec/controllers/home_controller_spec.rb").read

git :add => "."
git :commit => "-a -m 'Removed index.html. Added HomeController'"

# Setup Authentication
templ = case ask(<<-EOQ

Choose an Authentication method:
  1) Authlogic
  2) Clearance
  3) restful_authentication
  4) None of the above
EOQ
).to_s
  when '1'
    "#{SOURCE}/authlogic/base.rb"
  when '2'
    "#{SOURCE}/clearance/base.rb"
  when '3'
    "#{SOURCE}/restful_authentication/base.rb"
  else
    nil
end

load_template(templ) unless templ.nil?

puts "\n#{'*' * 80}\n\n"
unless @auth_message.nil?
  puts "#{@auth_message}"
  puts ''
end
puts "All done. Enjoy."
puts "\n#{'*' * 80}\n\n"

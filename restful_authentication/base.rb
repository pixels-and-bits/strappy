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
route open("#{SOURCE}/restful_authentication/config/restful_auth_routes.rb").read

# add gems to gems.yml
file_append('config/gems.yml',
  open("#{SOURCE}/restful_authentication/config/gems.yml").read)
run 'sudo gemtools install'

# add observer
lib 'user_observer.rb',
  open("#{SOURCE}/restful_authentication/lib/user_observer.rb").read

rake('db:migrate')
git :add => "."
git :commit => "-a -m 'Added RESTful Authentication'"

# Add ApplicationController
file 'app/controllers/application_controller.rb',
  open("#{SOURCE}/restful_authentication/app/controllers/application_controller.rb").read
git :add => "."
git :commit => "-a -m 'Added ApplicationController'"

# Application Layout
file 'app/views/layouts/application.html.haml',
  open("#{SOURCE}/restful_authentication/app/views/layouts/application.html.haml").read
git :add => "."
git :commit => "-a -m 'Added Layout'"

puts "\n#{'*' * 80}\n\n"
puts "Be sure to clean up the views converted to Haml (fix indenting, remove - end)"
puts "  app/views/sessions/new.html.haml"
puts "  app/views/users/new.html.haml"
puts "\n#{'*' * 80}\n"

@auth_message = <<-EOM
restful_authentication installed

Be sure to clean up the views converted to Haml (fix indenting, remove - end)
  app/views/sessions/new.html.haml
  app/views/users/new.html.haml
EOM

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
route open("#{SOURCE}/config/restful_auth_routes.rb").read

rake('db:migrate')
git :add => "."
git :commit => "-a -m 'Added RESTful Authentication'"

# Setup Authlogic

# add gems to gems.yml
file_append('config/gems.yml',
  open("#{SOURCE}/restful_authentication/config/gems.yml").read)
run 'sudo gemtools install'

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
  open("#{SOURCE}/authlogic/db/migrate/create_users.rb").read

# models
%w( user notifier ).each do |name|
  file "app/models/#{name}.rb",
    open("#{SOURCE}/authlogic/app/models/#{name}.rb").read
end

# controllers
%w( user_sessions password_reset users ).each do |name|
  file "app/controllers/#{name}_controller.rb",
    open("#{SOURCE}/authlogic/app/controllers/#{name}_controller.rb").read
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
  file "app/views/#{name}", open("#{SOURCE}/authlogic/app/views/#{name}").read
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
  controllers/password_reset_controller_spec.rb
  controllers/user_sessions_controller_spec.rb
  controllers/users_controller_spec.rb
).each do |name|
  file "spec/#{name}", open("#{SOURCE}/authlogic/spec/#{name}").read
end

rake('db:migrate')
git :add => "."
git :commit => "-a -m 'Added Authlogic'"

# Add ApplicationController
file 'app/controllers/application_controller.rb',
  open("#{SOURCE}/authlogic/app/controllers/application_controller.rb").read
git :add => "."
git :commit => "-a -m 'Added ApplicationController'"

# Application Layout
file 'app/views/layouts/application.html.haml',
  open("#{SOURCE}/authlogic/app/views/layouts/application.html.haml").read
git :add => "."
git :commit => "-a -m 'Added Layout'"


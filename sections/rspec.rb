# RSpec
gen 'rspec:install'
# file 'spec/rcov.opts', open("#{ENV['SOURCE']}/spec/rcov.opts").read
file_append('spec/spec_helper.rb', open("#{ENV['SOURCE']}/spec/helpers.rb").read)

run 'mkdir -p spec/fixtures'
%w(
  fixtures/users.yml
  helpers/application_helper_spec.rb
  controllers/password_reset_controller_spec.rb
  controllers/user_sessions_controller_spec.rb
  controllers/users_controller_spec.rb
  models/user_spec.rb
  views/home/index.html.haml_spec.rb
).each do |name|
  file "spec/#{name}", open("#{ENV['SOURCE']}/spec/#{name}").read
end

# cleanup any generated tests since we are using RSpec
run 'rm -rf test'

git :add => "."
git :commit => "-am 'Added RSpec'"

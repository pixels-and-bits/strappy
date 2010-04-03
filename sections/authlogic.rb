file_inject('/spec/spec_helper.rb',
  "require 'spec/rails'",
  "require 'authlogic/test_case'\n",
  :after
)

# Setup Authlogic
gen 'session user_session'

# allow login by login or pass
file_inject('/app/models/user_session.rb',
  "class UserSession < Authlogic::Session::Base",
  "  find_by_login_method :find_by_login_or_email",
  :after
)

gen 'rspec_controller user_sessions'
gen 'scaffold user'

# get rid of the generated templates
Dir.glob('app/views/users/*.erb').each do |file|
  run "rm #{file}"
end

run "rm app/views/layouts/users.html.erb"
gen 'controller password_reset'

git :add => "."
git :commit => "-am 'Setup Authlogic'"

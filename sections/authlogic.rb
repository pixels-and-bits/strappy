# Setup Authlogic
generate 'authlogic:session user_session'
generate 'controller user_sessions'
generate 'model user'

# # allow login by login or pass
# file_inject('app/models/user_session.rb',
#   "class UserSession < Authlogic::Session::Base",
#   "  find_by_login_method :find_by_login_or_email",
#   :after
# )

file_inject('spec/spec_helper.rb',
  "require 'spec/rails'",
  "require 'authlogic/test_case'\n",
  :after
)

# get rid of the generated templates
Dir.glob('app/views/users/*.erb').each do |file|
  rm file
end

generate 'controller password_reset'

git :add => "."
git :commit => "-am 'Setup Authlogic'"

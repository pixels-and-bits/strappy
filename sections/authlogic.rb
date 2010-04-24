# Setup Authlogic
generate 'authlogic:session user_session'
generate 'migration create_users'

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

# rm 'app/controllers/password_reset_conroller.rb'
# generate 'controller password_reset'

git :add => "."
git :commit => "-am 'Setup Authlogic'"

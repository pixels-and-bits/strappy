gem 'thoughtbot-clearance',
  :lib => 'clearance',
  :source => 'http://gems.github.com',
  :version => '>= 0.4.7'

# add gems to gems.yml
file_append('config/gems.yml',
  open("#{SOURCE}/clearance/config/gems.yml").read)
run 'sudo gemtools install'

generate 'clearance'

file 'app/controllers/application_controller.rb',
  open("#{SOURCE}/clearance/app/controllers/application_controller.rb").read

if File.exist?('app/controllers/application.rb')
  run 'rm app/controllers/application.rb'
end

initializer 'clearance.rb', <<-EOI
DO_NOT_REPLY=SiteConfig.mail_from
HOST=SiteConfig.host_name
EOI

route "map.logout '/logout', :controller => 'sessions', :action => 'destroy'"
route "map.login '/login', :controller => 'sessions', :action => 'new'"
route "map.signup '/signup', :controller => 'users', :action => 'new'"

git :add => "."
git :commit => "-a -m 'Added Clearance'"

crypto_name = nil
crypto = case ask(<<-EOQ

Which hashing algorithm do you want to use?
  1) SHA1 (default in Clearance)
  2) SHA512
  3) BCrypt
EOQ
).to_s
  when '2'
    crypto_name = 'SHA512'
    'include ClearanceCrypto::SHA512'
  when '3'
    crypto_name = 'BCrypt'
    'include ClearanceCrypto::BCrypt'
  else
    nil
end

if crypto
  file_append('config/gems.yml',
    open("#{SOURCE}/clearance/config/clearance_crypto_gems.yml").read)

  run 'sudo gemtools install'

  file_inject('app/models/user.rb',
    'class User < ActiveRecord::Base',
    "require 'clearance_crypto/#{crypto_name.downcase}'\n",
    :before
  )

  file_inject('app/models/user.rb',
    'include Clearance::App::Models::User',
    "  #{crypto}",
    :after
  )

  git :add => '.'
  git :commit => "-a -m 'Added ClearanceCrypto with #{crypto_name}'"
end

# Application Layout
file 'app/views/layouts/application.html.haml',
  open("#{SOURCE}/authlogic/app/views/layouts/application.html.haml").read

git :add => "."
git :commit => "-a -m 'Added Layout'"

@auth_message = 'Clearance authentication installed'
@auth_message << " with #{crypto_name} hashing" unless crypto_name.nil?
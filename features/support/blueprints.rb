require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.login { Faker::Internet.user_name }
Sham.first_name { Faker::Name.first_name }
Sham.last_name { Faker::Name.last_name }
Sham.email { Faker::Internet.email }

User.blueprint do
  login
  email
  admin { false }
  password { 'password' }
end

User.blueprint(:admin) do
  admin { true }
end

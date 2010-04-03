%w( migrate fixtures ).each do |d|
  run "mkdir -p db/#{d}"
end

# migrations
file_name = Dir.glob('db/migrate/*_create_users.rb').first
rm file_name
file file_name,
  open("#{ENV['SOURCE']}/db/migrate/create_users.rb").read

# fixtures
file "db/fixtures/users.rb", open("#{ENV['SOURCE']}/db/fixtures/users.rb").read

git :add => "."
git :commit => "-am 'added migrations and seed fixtures'"

rake 'db:migrate'
rake 'db:seed'

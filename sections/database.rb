# migrations
file Dir.glob('db/migrate/*_create_users.rb').first,
  open("#{ENV['SOURCE']}/db/migrate/create_users.rb").read

# fixtures
file "db/fixtures/users.rb", open("#{ENV['SOURCE']}/db/fixtures/users.rb").read

git :add => "."
git :commit => "-am 'added migrations and seed fixtures'"

rake 'db:migrate'
rake 'db:seed'

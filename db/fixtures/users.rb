User.seed(:login) do |s|
  s.login = 'admin'
  s.email = 'admin@example.com'
  s.password = 'changeme'
  s.admin = true
end

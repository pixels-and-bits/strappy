# Add ApplicationController
run 'rm app/controllers/application_controller.rb'

file 'app/controllers/application_controller.rb',
  open("#{ENV['SOURCE']}/app/controllers/application_controller.rb").read

%w( user_sessions password_reset users ).each do |name|
  file "app/controllers/#{name}_controller.rb",
    open("#{ENV['SOURCE']}/app/controllers/#{name}_controller.rb").read
end

run 'rm app/helpers/application_helper.rb'

file 'app/helpers/application_helper.rb',
  open("#{ENV['SOURCE']}/app/helpers/application_helper.rb").read

git :add => "."
git :commit => "-am 'Added Controllers'"

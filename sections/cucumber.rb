# Cucumber
gen "cucumber:skeleton --rspec #{WEB_DRIVER}"

# file_str_replace('config/cucumber.yml', 
#   %q{rerun = File.file?('rerun.txt') ? IO.read('rerun.txt') : ""},
#   %q{rerun = ""}
# )

%w(
  admin/admin_base.feature
  application/application_base.feature
  home/home.feature
  users/users.feature
  step_definitions/_common_steps.rb
  step_definitions/_custom_web_steps.rb
  step_definitions/user_steps.rb
  support/blueprints.rb
  support/paths.rb
).each do |name|
  file "features/#{name}", open("#{ENV['SOURCE']}/features/#{name}").read
end

git :add => "."
git :commit => "-am 'Added Cucumber'"

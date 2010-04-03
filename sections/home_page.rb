# Remove index.html and add HomeController
git :rm => 'public/index.html'
gen "rspec_controller home"

file 'app/views/home/index.html.haml',
  open("#{ENV['SOURCE']}/app/views/home/index.html.haml").read

file "app/helpers/home_helper.rb",
  open("#{ENV['SOURCE']}/app/helpers/home_helper.rb").read

file "spec/views/home/index.html.haml_spec.rb",
  open("#{ENV['SOURCE']}/spec/views/home/index.html.haml_spec.rb").read

file "spec/controllers/home_controller_spec.rb",
  open("#{ENV['SOURCE']}/spec/controllers/home_controller_spec.rb").read

git :add => "."
git :commit => "-am 'Removed index.html. Added HomeController'"

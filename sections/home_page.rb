# Remove index.html and add HomeController
git :rm => 'public/index.html'

file 'app/views/home/index.html.haml',
  open("#{ENV['SOURCE']}/app/views/home/index.html.haml").read

file "app/helpers/home_helper.rb",
  open("#{ENV['SOURCE']}/app/helpers/home_helper.rb").read

file "app/controllers/home_controller.rb",
  open("#{ENV['SOURCE']}/app/controllers/home_controller.rb").read

git :add => "."
git :commit => "-am 'Removed index.html. Added HomeController'"

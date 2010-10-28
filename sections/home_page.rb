# Remove index.html and add HomeController
git :rm => 'public/index.html'

generate 'controller home index'

git :add => "."
git :commit => "-am 'Removed index.html. Added HomeController'"

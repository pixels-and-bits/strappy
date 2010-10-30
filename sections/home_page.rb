# Remove index.html and add HomeController
git :rm => 'public/index.html'

generate 'controller home index'

# fix route
file_str_replace 'config/routes.rb',
  'get "home/index"',
  'root :to => "home#index"'

git :add => "."
git :commit => "-am 'Removed index.html. Added HomeController'"

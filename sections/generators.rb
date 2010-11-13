generate 'rspec:install'
generate 'cucumber:install --rspec --capybara'
generate 'machinist:install'
generate 'jquery:install --ui --force'
generate 'devise:install'

git :add => "."
git :commit => "-am 'Ran generators for compass-html5-boilerplate, devise, machinist, rspec and cucumber'"

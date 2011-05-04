generate 'rspec:install'
generate 'cucumber:install --rspec --capybara'
generate 'machinist:install'
generate 'jquery:install --ui --force --version 1.5.2'
generate 'devise:install'

git :add => "."
git :commit => "-am 'Ran generators for devise, machinist, rspec and cucumber'"

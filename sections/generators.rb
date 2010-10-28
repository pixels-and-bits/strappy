generate 'rspec:install'
generate 'cucumber:install --rspec --capybara'
generate 'machinist:install'
generate 'jquery:install --ui --force'
generate 'devise:install'

git :add => "."
git :commit => "-am 'Run generators for devise, machinist, rspec and cucumber'"

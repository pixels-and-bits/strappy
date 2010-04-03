# use this for local installs
ENV['SOURCE'] ||= 'http://github.com/pixels-and-bits/strappy/raw/master'

# functions needs to be first
%w(
  functions
  git
  gemfile
  core_extensions
  site_config
  capistrano
  admin
  haml
  jquery
  blackbird
  bundle_fu
  controllers
  home_page
  models
  images
  routes
  rspec
  capybara
  cucumber
  rake_tasks
  database
).each do |f|
  apply "#{ENV['SOURCE']}/sections/#{f}.rb"
end

puts "\n#{'*' * 80}\n\n"
puts "All done. Enjoy."
puts "\n#{'*' * 80}\n\n"

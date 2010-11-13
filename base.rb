# use this for local installs
ENV['SOURCE'] ||= 'http://github.com/pixels-and-bits/strappy/raw/master'

# functions needs to be first
%w(
  functions
  git
  gemfile
  config
  site_config
  generators
  capistrano
  html5-boilerplate
  admin
  haml
  blackbird
  home_page
  rake_tasks
  javascripts
  debugger
).each do |f|
  apply "#{ENV['SOURCE']}/sections/#{f}.rb"
end

rake 'db:migrate'
git :add => "."
git :commit => "-am 'commit schema'"

puts "\n#{'*' * 80}\n\n"
puts "All done. Enjoy."
puts "\n#{'*' * 80}\n\n"

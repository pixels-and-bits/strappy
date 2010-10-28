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
  admin
  haml
  blackbird
  home_page
  rake_tasks
  javascripts
).each do |f|
  apply "#{ENV['SOURCE']}/sections/#{f}.rb"
end

rake 'db:migrate'

puts "\n#{'*' * 80}\n\n"
puts "All done. Enjoy."
puts "\n#{'*' * 80}\n\n"

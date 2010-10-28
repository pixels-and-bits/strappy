file_append 'config/environemnts/development.rb',
<<-EOA

if defined?(PhusionPassenger)
  if File.exists?(Rails.root.join('tmp', 'debug.txt'))
    require 'ruby-debug'
    Debugger.wait_connection = true
    Debugger.start_remote
  end
end
EOA

git :add => "."
git :commit => "-am 'Add passenger enabled debugging'"

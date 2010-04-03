# Capistrano
file 'config/deploy.rb', open("#{ENV['SOURCE']}/config/deploy.rb").read

%w( production staging ).each do |env|
  file "config/deploy/#{env}.rb", <<-EOC
set :rails_env, "#{env}"
set :branch, "#{env}"
EOC
end

inside('config/environments') do
  run 'cp development.rb staging.rb'
end

git :add => "."
git :commit => "-am 'Added Capistrano config'"

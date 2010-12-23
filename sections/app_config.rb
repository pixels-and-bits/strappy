# SiteConfig
file 'config/app.yml', open("#{ENV['SOURCE']}/config/app.yml").read
lib 'app_config.rb', open("#{ENV['SOURCE']}/lib/app_config.rb").read
git :add => "."
git :commit => "-am 'Added SiteConfig'"

# SiteConfig
file 'config/site.yml', open("#{ENV['SOURCE']}/config/site.yml").read
lib 'site_config.rb', open("#{ENV['SOURCE']}/lib/site_config.rb").read
git :add => "."
git :commit => "-am 'Added SiteConfig'"

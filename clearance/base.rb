gem 'thoughtbot-clearance',
  :lib => 'clearance',
  :source => 'http://gems.github.com',
  :version => '>= 0.4.7'

# add gems to gems.yml
file_append('config/gems.yml',
  open("#{SOURCE}/clearance/config/gems.yml").read)
run 'sudo gemtools install'

generate 'clearance'

file 'app/controllers/application_controller.rb',
  open("#{SOURCE}/clearance/app/controllers/application_controller.rb").read

if File.exist?('app/controllers/application.rb')
  run 'rm app/controllers/application.rb'
end

initializer 'clearance.rb', <<-EOI
DO_NOT_REPLY=SiteConfig.mail_from
HOST=SiteConfig.host_name
EOI

route "map.logout '/logout', :controller => 'sessions', :action => 'destroy'"
route "map.login '/login', :controller => 'sessions', :action => 'new'"
route "map.signup '/signup', :controller => 'users', :action => 'new'"

git :add => "."
git :commit => "-a -m 'Added Clearance'"

# Application Layout
file 'app/views/layouts/application.html.haml',
  open("#{SOURCE}/authlogic/app/views/layouts/application.html.haml").read
git :add => "."
git :commit => "-a -m 'Added Layout'"

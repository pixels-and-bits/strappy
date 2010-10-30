# puts "TODO: Fix me for html5-boilerplate #{__FILE__}"
# NOTE: not sure what's happening with this yet
return

# install haml rake tasks
rakefile 'haml.rake', open("#{ENV['SOURCE']}/lib/tasks/haml.rake").read

run 'echo N\n | haml --rails .'

run 'mkdir -p public/stylesheets/sass'
%w(
  application
  print
  _colors
  _common
  _flash
  _forms
  _grid
  _helpers
  _reset
  _typography
).each do |file|
  file "public/stylesheets/sass/#{file}.sass",
    open("#{ENV['SOURCE']}/public/stylesheets/sass/#{file}.sass").read
end

# views
%w(
  notifier/password_reset_instructions.erb
  password_reset/edit.html.haml
  password_reset/new.html.haml
  user_sessions/new.html.haml
  users/_form.haml
  users/edit.html.haml
  users/new.html.haml
  users/show.html.haml
).each do |name|
  file "app/views/#{name}", open("#{ENV['SOURCE']}/app/views/#{name}").read
end

# layouts
%w(
  application.html.haml
  _body.html.haml
  _common_headers.html.haml
  _footer.html.haml
  _on_ready.html.haml
).each do |name|
  file "app/views/layouts/#{name}",
    open("#{ENV['SOURCE']}/app/views/layouts/#{name}").read
end

file "app/views/layouts/admin.html.haml",
  open("#{ENV['SOURCE']}/app/views/layouts/admin.html.haml").read
file "app/views/admin/base/index.html.haml",
  open("#{ENV['SOURCE']}/app/views/admin/base/index.html.haml").read
file "app/controllers/admin/base_controller.rb",
  open("#{ENV['SOURCE']}/app/controllers/admin/base_controller.rb").read
file "spec/controllers/admin/base_controller_spec.rb",
  open("#{ENV['SOURCE']}/spec/controllers/admin/base_controller_spec.rb").read
file "app/helpers/admin/base_helper.rb",
  open("#{ENV['SOURCE']}/app/helpers/admin/base_helper.rb").read

git :add => "."
git :commit => "-am 'Added Haml and Sass stylesheets'"

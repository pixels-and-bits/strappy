# Git
file_append '.gitignore', open("#{ENV['SOURCE']}/gitignore").read
git :init
git :add => '.gitignore'
rm 'public/images/rails.png'
run 'cp config/database.yml config/database.template.yml'
git :add => "."
git :commit => "-am 'Initial commit'"

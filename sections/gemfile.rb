# install Gemfile and gems
rm 'Gemfile'
file 'Gemfile', open("#{ENV['SOURCE']}/Gemfile").read
run 'bundle install'

git :add => "."
git :commit => "-am 'Add Gemfile'"

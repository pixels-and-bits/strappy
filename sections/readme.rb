# update the readme
run 'rm README'
file 'README.textile', open("#{ENV['SOURCE']}/README.textile").read
git :add => "."
git :commit => "-am 'Replaced README'"

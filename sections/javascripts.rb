rm 'public/javascripts/application.js'

file 'public/javascripts/application.js',
  open("#{ENV['SOURCE']}/public/javascripts/application.js").read

git :add => "."
git :commit => "-am 'Added starter application.js'"

run 'bundle exec compass init rails -r html5-boilerplate -u html5-boilerplate --force --sass-dir app/stylesheets --css-dir public/stylesheets'

git :add => "."
git :commit => "-am 'Ran compass init with html5-boilerplate'"

inside('public/javascripts') do
  %w(
    application.js
    controls.js
    dragdrop.js
    effects.js
    prototype.js
    rails.js
  ).each do |file|
    run "rm -f #{file}"
  end
end

# jQuery
file 'public/javascripts/jquery.js',
  open('http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js').read
file 'public/javascripts/jquery-ui.js',
  open('http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js').read
file 'public/javascripts/jquery.form.js',
  open('http://github.com/malsup/form/raw/master/jquery.form.js').read
file 'public/javascripts/application.js',
  open("#{ENV['SOURCE']}/public/javascripts/application.js").read

# Rails UJS for jQuery
file 'public/javascripts/rails.js', 
  open('http://github.com/rails/jquery-ujs/raw/master/src/rails.js').read

git :add => "."
git :commit => "-am 'Added jQuery with UI and form plugin'"

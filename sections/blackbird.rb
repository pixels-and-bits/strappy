# Blackbird
run 'mkdir -p public/blackbird'
file 'public/blackbird/blackbird.js',
  open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.js').read
file 'public/blackbird/blackbird.css',
  open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.css').read
file 'public/blackbird/blackbird.png',
  open('http://blackbirdjs.googlecode.com/svn/trunk/blackbird.png').read

git :add => "."
git :commit => "-am 'Added Blackbird'"

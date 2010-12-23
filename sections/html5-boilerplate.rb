git :rm => 'app/views/layouts/application.html.erb'

rm('public/favicon.ico')
rm('public/robots.txt')

%w(
  .htaccess
  apple-touch-icon.png
  crossdomain.xml
  favicon.ico
  nginx.conf
  robots.txt
).each do |file_name|
  file "public/#{file_name}",
    open("#{ENV['SOURCE']}/public/#{file_name}").read
end

%w(
  plugins.js
  libs/dd_belatedpng.js
  libs/modernizr-1.6.min.js
  libs/profiling/charts.swf
  libs/profiling/config.js
  libs/profiling/yahoo-profiling.css
  libs/profiling/yahoo-profiling.min.js
).each do |file_name|
  file "public/javascripts/#{file_name}",
    open("#{ENV['SOURCE']}/public/javascripts/#{file_name}").read
end

%w(
  views/layouts/application.html.haml
  views/layouts/_header.html.haml
  views/layouts/_footer.html.haml
  stylesheets/handheld.scss
  stylesheets/style.scss
).each do |file_name|
  file "app/#{file_name}",
    open("#{ENV['SOURCE']}/app/#{file_name}").read
end

git :add => "."
git :commit => "-am 'html5-boilerplate templates'"

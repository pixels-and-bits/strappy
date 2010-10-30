# javascripts
%w(
  profiling/charts.swf
  profiling/config.js
  profiling/yahoo-profiling.css
  profiling/yahoo-profiling.min.js
  dd_belatedpng.js
  modernizr.min.js
  plugins.js
).each do |file_name|
  file "public/javascripts/#{file_name}",
    open("#{ENV['SOURCE']}/public/javascripts/#{file_name}").read
end

# public_html
%w(
  .htaccess
  crossdomain.xml
).each do |file_name|
  file "public/#{file_name}",
    open("#{ENV['SOURCE']}/public/#{file_name}").read
end

# Sass templates
%w(
  style.scss
  handheld.scss
).each do |file_name|
  file "public/stylesheets/sass/#{file_name}",
    open("#{ENV['SOURCE']}/public/stylesheets/sass/#{file_name}").read
end

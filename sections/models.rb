# models
%w( user notifier ).each do |name|
  file "app/models/#{name}.rb",
    open("#{ENV['SOURCE']}/app/models/#{name}.rb").read
end

git :add => "."
git :commit => "-am 'Added models'"

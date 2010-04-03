# Add Action images
%w(
  add.png
  arrow_up_down.png
  delete.png
  pencil.png
  user_edit.png
).each do |name|
  file "public/images/#{name}",
    open("#{ENV['SOURCE']}/public/images/#{name}").read
end

git :add => "."
git :commit => "-am 'Added images'"

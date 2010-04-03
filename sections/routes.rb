file_inject 'config/routes.rb',
  'Application.routes.draw do |map|',
  open("#{ENV['SOURCE']}/config/routes.rb").read,
  :after

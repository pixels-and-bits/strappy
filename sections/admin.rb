generate 'devise admin'
generate 'controller admin/base index'

# fix routes
file_str_replace 'config/routes.rb',
  'get "base/index"',
  %Q{
  namespace :admin do
    root :to => 'base#index'
  end # namespace : admin
  }

file_str_replace 'config/routes.rb',
  'devise_for :admins',
  'devise_for :admin'

# force auth
file_inject 'app/controllers/admin/base_controller.rb',
  'class Admin::BaseController < ApplicationController', 
  '  before_filter :authenticate_admin!
'

git :add => "."
git :commit => "-am 'Added admin'"

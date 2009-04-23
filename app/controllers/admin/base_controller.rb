class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :admin_required, :set_title

  private

  def set_title
    set_page_title('Admin')
  end

  def admin_required
    unless current_user && current_user.admin?
      store_location
      flash[:warn] = "You must be an admin to access this page"
      redirect_to login_url
      return false
    end
  end
end

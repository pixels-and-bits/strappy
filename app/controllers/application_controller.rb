# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :blackbird_override

  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  protected

    # Automatically respond with 404 for ActiveRecord::RecordNotFound
    def record_not_found
      render :file => Rails.root.join('public', '404.html'), :status => 404
    end

    def blackbird_override
      if 'true' == params[:force_blackbird]
        session[:blackbird] = true
      end
    end
end

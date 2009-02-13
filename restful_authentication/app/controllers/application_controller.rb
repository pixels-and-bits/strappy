# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  before_filter :blackbird_override

  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  protected

    def blackbird_override
      if 'true' == params[:force_blackbird]
        session[:blackbird] = true
      end
    end
end

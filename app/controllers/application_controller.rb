# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all

  helper_method :current_user_session, :current_user, :page_title,
    :set_page_title

  before_filter :blackbird_override, :activate_authlogic

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def set_page_title(title)
    @page_title = title
  end

  def page_title
    @page_title ? "#{@page_title} - #{SiteConfig.site_name}" : SiteConfig.site_name
  end

  protected

    def blackbird_override
      if 'true' == params[:force_blackbird]
        session[:blackbird] = true
      end
    end

  private
    def current_user_session
      @current_user_session ||= UserSession.find
    end

    def current_user
      @current_user ||= current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def render(*args)
      if request.xhr?
        if args.blank?
          return super(:layout => false)
        else
          args.first[:layout] = false if args.first.is_a?(Hash) &&
            args.first[:layout].blank?
        end
      end
      super
    end

end

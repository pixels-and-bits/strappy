class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      respond_to do |format|
        format.html { redirect_back_or_default root_url }
        format.xml  { head :ok }
        format.json { head :ok }
      end
    else
      flash[:error] = 'Login failed!'
      respond_to do |format|
        format.html { render :action => :new }
        format.xml  { head :forbidden }
        format.json { head :forbidden }
      end
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    respond_to do |format|
      format.html { redirect_back_or_default login_url }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end

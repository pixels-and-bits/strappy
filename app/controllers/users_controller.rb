class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def create
    params[:user][:password_confirmation] = params[:user][:password] if params[:user]
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_path
    else
      render :action => :new
    end
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_path
    else
      render :action => :edit
    end
  end
end

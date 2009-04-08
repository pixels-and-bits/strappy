require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  fixtures :users

  before do
    activate_authlogic
  end

  describe "actions requiring no current user" do
    it "should not redirect for a non-logged in user on :new" do
      get :new
      response.should_not be_redirect
    end

    it "should not redirect for a non-logged in user on :create" do
      get :create
      response.should_not be_redirect
    end

    it "should redirect for a logged in user on :new" do
      UserSession.create(users(:mmoen))
      get :new
      response.should be_redirect
    end

    it "should redirect for a logged in user on :create" do
      UserSession.create(users(:mmoen))
      get :create
      response.should be_redirect
    end
  end

  describe "actions requiring a current user" do
    it "should redirect to login on :destroy" do
      get :destroy
      response.should redirect_to(login_path)
    end
  end

  describe "session management" do
    it "should redirect to the account page on successful login" do
      post :create, :user_session => { :login => 'mmoen', :password => 'password' }
      response.should redirect_to(account_path)
    end

    it "should redirect to the login page on session deletion" do
      UserSession.create(users(:mmoen))
      post :destroy
      response.should redirect_to(login_path)
    end
  end
end

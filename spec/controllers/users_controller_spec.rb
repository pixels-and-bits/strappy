require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
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

    it "should redirect to account on successful :create" do
      post :create, :user => { :login => 'bob', :email => 'bob@example.com',
        :password => 'bobs_pass', :password_confirmation => 'bobs_pass' }
      response.should redirect_to(account_path)
    end
  end

  describe "actions requiring a current user" do
    it "should redirect to login on :show" do
      get :show
      response.should redirect_to(login_path)
    end

    it "should redirect to login on :edit" do
      get :edit
      response.should redirect_to(login_path)
    end

    it "should redirect to login on :update" do
      get :update
      response.should redirect_to(login_path)
    end

    it "should not redirect to login on :show" do
      UserSession.create(users(:mmoen))
      get :show
      response.should_not be_redirect
    end

    it "should not redirect to login on :edit" do
      UserSession.create(users(:mmoen))
      get :edit
      response.should_not be_redirect
    end

    it "should redirect to account on :update" do
      UserSession.create(users(:mmoen))
      post :update, :user => { :email => 'new_valid_email@example.com' }
      response.should redirect_to(account_path)
    end

    it "should not redirect to account on failed :update" do
      UserSession.create(users(:mmoen))
      post :update, :user => { :email => 'not_a_valid_email' }
      response.should_not be_redirect
    end
  end
end

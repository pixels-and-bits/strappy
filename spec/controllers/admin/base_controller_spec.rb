require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::BaseController do
  fixtures :users
  before do
    activate_authlogic
  end

  it "should require an admin user" do
    UserSession.create(users(:admin))
    get :index
    response.should be_success
  end

  it "should redirect to login for no user or non-admin user" do
    get :index
    response.should redirect_to(login_path)

    UserSession.create(users(:mmoen))
    get :index
    response.should redirect_to(login_path)
  end
end

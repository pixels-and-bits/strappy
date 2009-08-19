require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetController do
  fixtures :users

  before do
    activate_authlogic
  end

  describe "requesting a password reset" do
    it "should send an email to the user if found" do
      Notifier.stub!(:password_reset_instructions).and_return(nil)
      post :create, :email => 'michael@pixels-and-bits.com'
      users(:mmoen).perishable_token.should_not eql('')
      response.should redirect_to(root_url)
    end

    it "should re-render the new template on invalid email" do
      post :create, :email => 'michael@example.com'
      users(:mmoen).perishable_token.should eql('')
      response.should_not be_redirect
    end

    it "should change password with a valid token" do
      users(:mmoen).reset_perishable_token!
      post :update, :id => users(:mmoen).perishable_token, :user => {
        :password => 'new_pass' }
      response.should redirect_to(account_url)
    end

    it "should not change password with an invalid token" do
      post :update, :id => 'not_a_valid_token', :user => {
        :password => 'new_pass' }
      response.should redirect_to(root_url)
    end
  end
end

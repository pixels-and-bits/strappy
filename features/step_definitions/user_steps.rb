require "authlogic/test_case"

Before do
  # include Authlogic::TestCase
  activate_authlogic
end

Given /^a user$/ do
  @user = User.make
end

Given /^a logged in user$/ do
  @user = User.make
  UserSession.create(@user)
end

When /^I fill in and submit the forgot password form$/ do
  fill_in('email', :with => @user.email)
  click_button('Submit')
end

When /^I fill in and submit the new password form$/ do
  fill_in('password', :with => 'my_new_password')
  click_button('Update')
end

When /^I fill in and submit the login form with "([^\"]*)"$/ do |field|
  fill_in('user_session[login]', :with => @user.send(field))
  fill_in('user_session[password]', :with => 'password')
  click_button('Login')
end

Then /^the user should have an email$/ do
  @mailbox = mailbox_for(@user.email)
end

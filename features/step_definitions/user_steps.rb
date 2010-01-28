require "authlogic/test_case"

Before do
  # include Authlogic::TestCase
  activate_authlogic
end

Given /^a user$/ do
  @user = User.make
end

Given /^an admin user$/ do
  @user = User.make(:admin)
end

Given /^a logged in user$/ do
  steps %Q{
    Given a user
     When I am on the login page
     When I fill in and submit the login form with "login"
     Then I should see "Login successful"
  }
end

Given /^a logged in admin user$/ do
  steps %Q{
    Given an admin user
     When I am on the login page
     When I fill in and submit the login form with "login"
     Then I should see "Login successful"
  }
end

When /^I fill in and submit the forgot password form$/ do
  fill_in('email', :with => @user.email)
  click_button('Submit')
end


When /^I fill in and submit the forgot password form with an invalid email$/ do
  fill_in('email', :with => 'not_a_valid_email@example.com')
  click_button('Submit')
end

When /^I fill in and submit the new password form$/ do
  fill_in('password', :with => 'my_new_password')
  click_button('Update')
end

When /^I fill in and submit the new password form with "([^\"]*)"$/ do |pass|
  fill_in('password', :with => pass)
  click_button('Update')
end

When /^I fill in and submit the login form with "([^\"]*)"$/ do |field|
  fill_in('user_session[login]', :with => @user.send(field))
  fill_in('user_session[password]', :with => 'password')
  click_button('Login')
end

When /^I fill in and submit the login form with "([^\"]*)" of "([^\"]*)"$/ do |name, value|
  fill_in("user_session[#{name}]", :with => value)
  fill_in('user_session[password]', :with => 'password')
  click_button('Login')
end

When /^I fill in and submit the account edit form with valid info$/ do
  steps %Q{
    When I am on the account edit page
     And I fill in "user[login]" with "scooby"
     And I fill in "user[email]" with "scooby@example.com"
     And I press "Update"
  }
end

Given /^I fill in and submit the account edit form with "([^\"]*)" of "([^\"]*)"$/ do |name, value|
  steps %Q{
    When I am on the account edit page
     And I fill in "user[login]" with "scooby"
     And I fill in "user[email]" with "scooby@example.com"
     And I fill in "user[#{name}]" with "#{value}"
     And I press "Update"
  }
end

When /^I fill in and submit the signup form with valid info$/ do
  steps %Q{
    When I am on the signup page
     And I fill in "user[login]" with "scooby"
     And I fill in "user[email]" with "scooby@example.com"
     And I fill in "user[password]" with "password"
     And I press "Register"
  }
end

When /^I fill in and submit the signup form with "([^\"]*)" of "([^\"]*)"$/ do |name, value|
  steps %Q{
    When I am on the signup page
     And I fill in "user[login]" with "scooby"
     And I fill in "user[email]" with "scooby@example.com"
     And I fill in "user[password]" with "password"
     And I fill in "user[#{name}]" with "#{value}"
     And I press "Register"
  }
end

Then /^I follow an invalid password reset link$/ do
  link = links_in_email(current_email).first.gsub(%r{/password_reset/(.*?)/edit}, '/password_reset/bad_token/edit')
  request_uri = URI::parse(link).request_uri
  visit request_uri
end

Then /^the user should have an email$/ do
  @mailbox = mailbox_for(@user.email)
end

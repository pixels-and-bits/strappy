Feature: As an end user
  I want to perform common actions

  Scenario: Creating a new account
     When I am on the signup page
      And I fill in "user[login]" with "scooby"
      And I fill in "user[email]" with "scooby@example.com"
      And I fill in "user[password]" with "password"
      And I press "Register"
     Then I should see "Account registered"
      
  Scenario: Logging in as an existing user with "email"
    Given a user
     When I am on the login page
      And I fill in and submit the login form with "email"
     Then I should see "Login successful"

   Scenario: Logging in as an existing user with "login"
     Given a user
      When I am on the login page
       And I fill in and submit the login form with "email"
      Then I should see "Login successful"

  Scenario: Logging out
    Given a user
     When I am on the login page
      And I fill in and submit the login form with "email"
     Then I should see "Login successful"
      And I follow "sign out"
     Then I should see "Logout successful"

   Scenario: Requesting a password reset and resetting password
     Given a user
      When I am on the forgot password page
       And I fill in and submit the forgot password form
      Then I should see "Instructions to reset your password have been emailed to you"
       And I open the email with subject "Password Reset Instructions"
       And they should see "A request to reset your password has been made" in the email body
       And I click the first link in the email
      Then I should see "Change My Password"
      When I fill in and submit the new password form
      Then I should see "Password successfully updated"

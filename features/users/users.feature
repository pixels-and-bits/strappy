Feature: As an end user
  I want to perform common user actions

  Scenario: I want to create a new account with valid info
    When I fill in and submit the signup form with valid info
    Then I should see "Account registered"
      
  Scenario: I want to create a new account with an invalid email
    When I fill in and submit the signup form with "email" of "bad@example"
    Then I should not see "Account registered"
     And I should see "prohibited this user from being saved"

  Scenario: I want to create a new account with an invalid login
    When I fill in and submit the signup form with "login" of "no"
    Then I should not see "Account registered"
     And I should see "prohibited this user from being saved"

  Scenario: Logging in as an existing user with email
    Given a user
     When I am on the login page
      And I fill in and submit the login form with "email"
     Then I should see "Login successful"

  Scenario: Logging in as an existing user with login
    Given a user
     When I am on the login page
      And I fill in and submit the login form with "email"
     Then I should see "Login successful"

  Scenario: Logging in as an existing user with an invalid login
    Given a user
     When I am on the login page
      And I fill in and submit the login form with "login" of "nonexistent_user"
     Then I should see "Login failed"

  Scenario: Logging out
    Given a logged in user
      And I follow "sign out"
     Then I should see "Logout successful"

  Scenario: Updating my account with valid info
    Given a logged in user
      And I fill in and submit the account edit form with valid info
     Then I should be on the account page
      And I should see "Account updated"

  Scenario: Updating my account with an invalid email
    Given a logged in user
      And I fill in and submit the account edit form with "email" of "bad@example"
     Then I should be on the account page
      And I should see "prohibited this user from being saved"

  Scenario: Requesting a password reset and resetting password
    Given a user
     When I am on the forgot password page
      And I fill in and submit the forgot password form
     Then I should see "Instructions to reset your password have been emailed to you"
      And I open the email with subject "Password Reset Instructions"
      And I should see "A request to reset your password has been made" in the email body
      And I click the first link in the email
     Then I should see "Change My Password"
     When I fill in and submit the new password form
     Then I should see "Password successfully updated"

  Scenario: Requesting a password reset and resetting password with an invalid password
    Given this is pending
    Given a user
     When I am on the forgot password page
      And I fill in and submit the forgot password form
     Then I should see "Instructions to reset your password have been emailed to you"
      And I open the email with subject "Password Reset Instructions"
      And I should see "A request to reset your password has been made" in the email body
      And I click the first link in the email
     Then I should see "Change My Password"
     When I fill in and submit the new password form with "x"
     Then I should not see "Password successfully updated"

  Scenario: Requesting a password reset and resetting password with an invalid token
    Given a user
     When I am on the forgot password page
      And I fill in and submit the forgot password form
     Then I should see "Instructions to reset your password have been emailed to you"
      And I open the email with subject "Password Reset Instructions"
      And I should see "A request to reset your password has been made" in the email body
      And I follow an invalid password reset link
     Then I should see "we could not locate your account"

  Scenario: Requesting a password reset with an invalid email
    Given a user
     When I am on the forgot password page
      And I fill in and submit the forgot password form with an invalid email
     Then I should see "No user was found with that email address"
      And I should see "Fill out the form below"

  Scenario: Accessing an account page as an anonymous user
    Given a user
     When I am on the account page
     Then I should be on the login page

  Scenario: Accessing login page as a logged in user
    Given a logged in user
     When I am on the login page
     Then I should be on the account page

Feature: As the system
  I want to make sure only the proper people can get to the admin

  Scenario: An anonymous user tries to access the admin
    When I am on the admin page
    Then I should not be on the admin page

  Scenario: A logged in user tries to access the admin
    Given a logged in user
     When I am on the admin page
     Then I should not be on the admin page

  Scenario: An admin user tries to access the admin
    Given a logged in admin user
     When I am on the admin page
     Then I should be on the admin page

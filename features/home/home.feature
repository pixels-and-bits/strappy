Feature: As an end user
  I want to visit the home page
  
  Scenario: Visiting the home page
    When I am on the home page
    Then I should see "Welcome"
    And I should not see "blackbird"
    And I should not see "google-analytics"

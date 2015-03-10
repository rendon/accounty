Feature: User profile feature
  As an accountant
  I want to have a profile page
  So that I can visualize my user information

  Scenario: The user is logged in
    Given I am logged in
    And I am at the home page
    When I go to my settings page
    Then I should see my user information

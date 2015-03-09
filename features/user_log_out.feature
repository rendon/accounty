Feature: User log out
  As an accountant
  I want to log out from my account
  So that nobody else can use my account

  Scenario:
    Given I am logged in
    And I am at the home page
    When I log out
    Then I should be logged out

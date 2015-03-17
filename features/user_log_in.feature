Feature: User log in
  As an accountant
  I want to log in to my account
  So that I can start work with my account

  Scenario: log in with valid data
    Given I am at the log in page
    And I have an account
    When I log in with valid data
    Then I should be logged in
    And I should be at the dashboard

  Scenario: log in with non-registered email
    Given I am at the log in page
    And I have an account
    When I log in with non-registered email
    Then I should not be logged in

  Scenario: log in with wrong password
    Given I am at the log in page
    And I have an account
    And I log in with the wrong password
    Then I should not be logged in

  Scenario: Redirect to the requested resource after login
    Given I have an account
    When I go to my profile page
    Then I should be redirected to the login page
    When I log in with valid data
    Then I should be at my profile page


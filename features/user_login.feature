Feature: User login
  As an accountant
  I want to login to my account
  So that I can start work with my account

  Scenario: login with valid data
    Given I am at the login page
    And I have an account
    When I login with valid data
    Then I should be logged in

  Scenario: login with non-registered email
    Given I am at the login page
    And I have an account
    When I login with non-registered email
    Then I should not be logged in

  Scenario: login with wrong password
    Given I am at the login page
    And I have an account
    And I login with the wrong password
    Then I should not be logged in

Feature: Sign Up
  As an accountant
  I want to create an account
  So that I can use the application
  
  Scenario: Sign up with valid data
    Given I am at the sign up page
    When I sign up with valid data
    Then I should be logged in
    And I should be at the dashboard

  Scenario: Sign up with invalid email
    Given I am at the sign up page
    When I sign up with an invalid email
    Then I should not be signed in

  Scenario: Sign up without a name
    Given I am at the sign up page
    When I sign up without a name
    Then I should not be signed in

  Scenario: Sign up with a weak password
    Given I am at the sign up page
    When I sign up with a weak password
    Then I should not be signed in

Feature: Register operation
  As an accountant
  I want to register operations to my company
  So that I can keep track of the resources

  Background: Log in and go to the company page
    Given I am logged in
    And I have a company

  Scenario: Display option at the company page
    Given I am at the dashboard page
    When I select my company
    Then I should see the "Operations" link

  Scenario: Register operation
    Given I am at the dashboard page
    When I select my company
    When I go to the company Operations
    And I add an operation
    Then I should be at the operation page

  #Scenario: Add details to an operation
  #  Given I have registered my accounts
  #  And I have created an operation
  #  And I am at the operation page
  #  When I add an operation details
  #  Then I should see the new detail in the list

Feature: Add account to a company
  As a company owner
  I want to add accounts to my company
  So that I can categorize my operations

  Background: Log in and go to the company page
    Given I am logged in
    And I have a company
    And I am at the dashboard page

  Scenario: Display option at the company page
    Given I select my company
    Then I should see the "Accounts" link

  Scenario: Add account
    Given I select my company
    When I go to the company Accounts
    And I add and account
    Then I should see that account listed

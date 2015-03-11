Feature: Dashboard
  As an accountant
  I want a dashboard
  So that I can control all my operations from there

  Scenario: Brand new user
    Given I am logged in
    When I go to the home page
    Then I should see my dashboard

  Scenario: Add my first company
    Given I am logged in
    And I do not have companies
    When I go to the dashboard
    And I create a company
    Then I should have a company

  Scenario: Add another company
    Given I am logged in
    And I have a company
    When I go to the dashboard
    And I create a company
    Then I should have two companies

  Scenario: User with companies
    Given I am logged in
    And I have companies
    When I go to the dashboard
    Then I should see my companies

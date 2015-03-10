Feature: Dashboard
  As an accountant
  I want a dashboard
  So that I can control all my operations from there

  Scenario: Logged in accountant
    Given I am logged in
    When I go to the home page
    Then I should see my dashboard


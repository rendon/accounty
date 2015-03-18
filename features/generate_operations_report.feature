Feature: Generate operations report
  As an accountant
  I want to generate reports of my operations
  So that I can know how the resources were spent


  Scenario: Report of a custome period of time
    Given I am logged in
    And I have a company
    And I have done operations by three months
    When I go to Operations
    And I generate a report of the previous month
    Then I should see only the operations of the previous month

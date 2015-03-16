Feature: Add operation detail to an operation
  As an accountant
  I want to add the details to an operation
  So that I can know exactly how the resource was spent

Scenario: Add details to an operation
  Given I am logged in
  And I have a company
  And I have registered my accounts
  And I have created an operation
  And I am at the operation page
  When I add a detail to the operation
  Then I should see the new detail in the list

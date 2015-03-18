Feature: Create site's static pages
  As a visitor
  I want to see the same design all over the site
  So that I can locate common sections easily

  Scenario: Site structure
    Given I am at the home page
    Then I should see a link with "Accounty"
    And I should see a link with "Help"
    And I should see a link with "About"
    And I should see "Accounty (C) 2015 Rafael Rendón Pablo"

  Scenario: Home page
    Given I am at the home page
    Then I should see "Welcome to Accounty"
    And I should see a link with "Sign Up"

  Scenario: Help page
    Given I am at the help page
    Then I should see a link with "Help"

  Scenario: About page
    Given I am at the about page
    Then I should see a link with "About"
    And I should see "About Accounty"

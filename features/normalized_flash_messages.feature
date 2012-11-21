Feature: Normalize flash messages
    As an admin,
    So that I can display all error messages
    I want to display all messages using flash and display the proper error message when generated.

Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Non-project-members cannot View/Edit a project.
    Given I am logged in as Sherry
    And I am on the project page
    When I go to the project page for "Second Project"
    Then I should see "Sorry, you don't have access to the requested project."

Scenario: Non-project members cannot add risk to a project.
    Given I am logged in as Sherry
    When I go to Second Project's Add Risk page
    Then I should see "Sorry, you don't have access to the requested project."

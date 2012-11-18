Feature: Normalize flash messages
    As an admin,
    So that I can display all error messages
    I want to display all messages using flash and display the proper error message when generated.

Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: View a project that the user is not a member of.
    Given I am logged in as Linda
    And I am on the project page
    When I go to the project page for "Second Project"
    Then I should see "Sorry, you don't have access to the requested project."

Scenario: Add risk to a project when user doesn't have permission to add risk.
    Given I am logged in as Linda
    When I go to Second Project's Add Risk page
    Then I should see "Sorry, you don't have access to the requested project."

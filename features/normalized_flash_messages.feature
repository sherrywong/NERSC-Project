Feature: Normalize flash messages
    As an admin,
    So that I can display all error messages
    I want to display all messages using flash and display the proper error message when generated.

Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Non-project-members cannont View/Edit a project.
    Given I am logged in as Sherry
    And I am on the project page
    When I go to the project page for "Second Project"
    Then I should see "Sorry, you don't have access to the requested project."

Scenario: View a risk that the user doesn't have read permission
    When I go to Second Project's Add Risk page
#    Then I should see "Error: Don't have permission to view the risks associated with this project."

Scenario: Add risk to a project as a non-project-member.
    Given I am logged in as Sherry
    When I go to Second Project's Add Risk page
    Then I should see "Sorry, you don't have access to the requested project."

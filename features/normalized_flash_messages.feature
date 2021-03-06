Feature: Normalize flash messages
    As an admin,
    So that I can display all error messages
    I want to display all messages using flash and display the proper error message when generated.

Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Non-admins cannot view system users.
    Given I am logged in as Jason
    And I go to the show users page
    Then I should see "Sorry, you have to be an admin to perform this action."

Scenario: Non-project members cannot view a project.
    Given I am logged in as Sherry
    And I am on the home page
    When I go to the project page for "Second Project"
    Then I should see "Sorry, you don't have access to the requested project."

Scenario: Non-project members cannot view risks associated with a project.
    Given I am logged in as Sherry
    When I go to the risk index page for Second Project
    Then I should see "Sorry, you don't have access to the requested project."

Scenario: Non-project members cannot view a risk in a project.
    Given I am logged in as Sherry
    When I go to the Risk page for Third Risk in the second project
    Then I should see "Sorry, you don't have access to the requested project."



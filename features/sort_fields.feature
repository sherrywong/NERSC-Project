Feature: Sort fields (for projects/risks/users)
    As a user,
    So that I can search for a project and risk easily,
    I want to be able to sort all projects and risks

Background: Some projects and risks have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Sort projects.
    And I am on the home page
    Then I sort projects

Scenario: Sort project members.
    When I go to the project page for "First Project"
    Then I sort "First Project" project members

Scenario: Sort project members on project edit page.
    When I go to the edit project page for "First Project"
    Then I sort "First Project" project members

Scenario: Sort risk.
    When I go to the risk index page for First Project
    Then I sort risks for "First Project"

Scenario: Sort system users.
    When I go to the show users page
    Then I sort users


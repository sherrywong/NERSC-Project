Feature: 'Sort by' for projects and risks
    As a user,
    So that I can search for a project and risk easily,
    I want to be able to sort all projects and risks

Background: Some projects and risks have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist

Scenario: Sort projects.
    Given I am logged in as an admin
    And I am on the project page
    Then I sort projects by "title"
    Then I sort projects by "status"
    Then I sort projects by "owner"

Scenario: Sort project members.
    When I go to the project page for "First Project"
    Then I sort "First Project" project members by "members"
    Then I sort "First Project" project members by "first"
    Then I sort "First Project" project members by "last"
    Then I sort "First Project" project members by "email"

Scenario: Sort risk.
    When I go to the risk index page for First Project
    Then I sort risks for "First Project" by "title"
    Then I sort risks for "First Project" by "owner"
    Then I sort risks for "First Project" by "early_impact"
    Then I sort risks for "First Project" by "last_impact"
    Then I sort risks for "First Project" by "status"

Scenario: Sort system users.
    When I go to the project page
    And I go to the show users page
    Then I sort users by "username"
    Then I sort users by "first"
    Then I sort users by "last"
    Then I sort users by "email"
    Then I sort users by "admin"
    Then I sort users by "status"


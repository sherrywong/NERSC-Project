Feature: Validate a project 
    As a user,
    So that I can catch my own mistakes
    I want to be notified if a project is missing fields.

Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Add project with missing fields.
    When I go to the new project page
    When I fill in "project_description" with "Project 5"
    And I select "admin" from "project[owner_username]"
    Then I press "Save" 
    Then I should be on the new project page

Scenario: Add a project with a name and prefix as an existing project.
    When I go to the new project page 
    When I fill in "project_name" with "First Project"
    When I fill in "project_description" with "proj1"
    And I select "admin" from "project[owner_username]"
    Then I press "Save"
    Then there should be this message: "Prefix has already been taken"

Scenario: Admin cannot add a project with a deactivated user as its owner
    When I go to the new project page
    Then I should not see "em" as an option for owner

Feature: Create a project 
    As an administrator, 
    So that I can capture and share information about a project I am working on 
    I want to be able to create a project and share it with project members 

#Feature: Add Project Fields
#    As a project owner,
#    So I can have more comprehensive information about my projects,
#    I want to be able to add and edit a variety of information to each project.
  
Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Add a valid project.
    Given I am logged in as an admin
    And I am on the project page
    When I go to the new project page
    When I fill in "project_name" with "Test Project" 
    And I fill in "project_prefix" with "test"
    And I fill in "project_description" with "Project 4"
    And I fill in "project_owner_username" with "admin"
    Then I press "Save" 
    Then I should be on the project page
    And I should see "Project 'Test Project' created."
    And I should see "Test Project"

Scenario: Edit a project.
    Given I am logged in as an admin
    When I go to the project page for "First Project"
    Then I should see "Matrix"
    When I fill in "project_name" with "Test Project2"
    Then I press "Save"
    Then I should see "Project 'Test Project2' was succesfully updated."

Scenario: Add project with missing fields.
    And I am on the project page
    When I go to the new project page
    When I fill in "project_description" with "Project 5"
    Then I press "Save" 
#    Then I should be on the new project page 

Scenario: View a project that the user doesn't have read permissions.
    Given I am logged in as an admin
    And I am on the project page
    When I go to the project page for "First Project"
#    Then I should see "Don't have permission to view this project."

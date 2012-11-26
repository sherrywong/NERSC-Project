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

Scenario: Admins can add a valid project.
    Given I am logged in as an admin
    And I am on the project page
    When I press "+ Create New Project"
    And I am on the new project page
    When I fill in "project_name" with "Test Project" 
    And I fill in "project_prefix" with "test"
    And I fill in "project_description" with "Project 4"
    And I fill in "project_owner_username" with "admin"
    Then I press "Save" 
    Then I should be on the project page
    And I should see "Project 'Test Project' created."
    And I should see "Test Project"

Scenario: Add project with missing fields.
    Given I am logged in as an admin
    And I am on the project page
    When I press "+ Create New Project"
    And I am on the new project page
    When I fill in "project_description" with "Project 5"
    Then I press "Save" 
#    Then I should be on the new project page

Scenario: Non-admins cannot add a project.
    Given I am logged in as Jason
    And I am on the project page
    When I go to the new project page
    Then I should see "Sorry, you have to be an admin to perform this action."

Scenario: Admins can edit a project.
    Given I am logged in as an admin
    And I am on the project page
    When I follow "First Project"
    And I am on the project page for "First Project"
    Then I should see "Matrix"
    When I fill in "project_name" with "Test Project2"
    Then I press "Save"
    Then I should be on the project page
    Then I should see "Project 'Test Project2' was succesfully updated."

Scenario: Project owners can edit a project.
    Given I am logged in as Jason
    And I am on the project page
    When I follow "Second Project"
    Then I should be on the project page for "Second Project"
    When I fill in "project_name" with "Edit Name"
    Then I press "Save"
    Then I should be on the project page
    Then I should see "Project 'Edit Name' was succesfully updated."

Scenario: Project members cannot edit a project.
    Given I am logged in as Linda
    And I am on the project page
    When I follow "Second Project"
    Then I should be on the project page for "Second Project"
    Then I should not see "Save"

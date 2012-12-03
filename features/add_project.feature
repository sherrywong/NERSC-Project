Feature: Add project
    As an administrator, 
    So that I can capture and share information about a project I am working on 
    I want to be able to create a project and share it with project members

#Feature: Project Risk Matrix
#    As a project owner,
#    So that I can set parameters and categories for that project's risks,
#    I should be ale to set project specific risk parameters.

#Feature: Add Project Fields
#    As a project owner,
#    So I can have more comprehensive information about my projects,
#    I want to be able to add and edit a variety of information to each project.
  
Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Admins can add a valid project with a valid risk matrix
    Given I am logged in as an admin
    And I am on the home page
    When I press "+ Create New Project"
    And I am on the new project page
    When I fill in "project_name" with "Test Project" 
    And I fill in "project_prefix" with "test"
    And I fill in "project_description" with "Project 4"
    And I select "admin" from "project[owner_username]"
    When I select "Low" from "project[probability_impact_11]"
    When I select "High" from "project[probability_impact_21]"
    When I select "Med" from "project[probability_impact_12]"
    Then I press "Save" 
    Then I should be on the project page for "Test Project"
    And I should see "Project 'Test Project' created."
    And I should see "Test Project"

Scenario: Non-admins cannot add a project.
    Given I am logged in as Jason
    And I am on the home page
    When I go to the new project page
    Then I should see "Sorry, you have to be an admin to perform this action."

Scenario: Admins can edit a project.
    Given I am logged in as an admin
    And I am on the home page
    When I follow "First Project"
    Then I press "+ Edit Project"
    And I am on the edit project page for "First Project"
    Then I should see "Matrix"
    When I fill in "project_name" with "Test Project2"
    Then I press "Save"
    Then I should be on the project page for "Test Project2"
    Then I should see "Project 'Test Project2' was succesfully updated."

Scenario: Project owners can edit a project.
    Given I am logged in as Jason
    And I am on the home page
    When I follow "Second Project"
    When I press "+ Edit Project"
    Then I should be on the edit project page for "Second Project"
    When I fill in "project_name" with "Edit Name"
    Then I press "Save"
    Then I should be on the project page for "Edit Name"
    Then I should see "Project 'Edit Name' was succesfully updated."

Scenario: Project members cannot edit a project.
    Given I am logged in as Linda
    And I am on the home page
    When I follow "Second Project"
    Then I should not see "+ Edit Project"

Scenario: Admins can view a project that is not apart of.
    Given I am logged in as an admin
    And I am on the home page
    And I should see "Second Project"

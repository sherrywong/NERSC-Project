Feature: Deactivate a project
    As a project owner or admin,
    So that I can remove completed projects from the system
    I want to be able to delete projects
    
Background: Some projects are already in the database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Admins can deactivate a project.
    Given I am logged in as an admin
    And I am on the home page
    And I click on deactivate project for "First Project"
#confirmation?
    Then I should be on the home page
    And I should see "Project 'First Project' deactivated."
    Then there should not be deactivate project for "First Project"
    
Scenario: Project owners can deactivate their own projects.
    Given I am logged in as Jason
    And I am on the project page for "Second Project"
    And I click on deactivate project for "Second Project"
#confirmation?
    Then I should be on the home page
    And I should see "Project 'Second Project' deactivated."
    Then there should not be deactivate project for "Second Project"

Scenario: Project members cannot deactivate projects.
    Given I am logged in as Linda
    And I am on the home page
    Then there should not be deactivate project for "Second Project"
    And I click on deactivate project for "Second Project"
    Then I should be on the home page
    Then I should see "Sorry, you have to be an admin or project owner to perform this action."
  
Scenario: Project owners cannot deactivate other projects.
    Given I am logged in as Jason
    Then there should not be deactivate project for "First Project"

Scenario: Users not associated with the project cannot deactivate projects.
    Given I am logged in as Sherry
    And I click on deactivate project for "Second Project"
    Then I should see "Sorry, you don't have access to the requested project."

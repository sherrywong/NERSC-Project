Feature: Deactivate a project
    As a project owner or admin,
    So that I can remove completed projects from the system
    I want to be able to delete projects
    
Background: some projects and risks are already in the database.
    Given a set of users exist
    Given a set of projects exist

Scenario: Delete project
    Given I am logged in as an admin
    And I am on the project page
    And I click on delete project for "First Project"
    And I should see "Project 'First Project' deactivated."	

Scenario: Admins can delete
    Given I am logged in as an admin
    And I am on the project page for "Second Project"
    When I press "delete_project"
    And I press "Yes" 
#confirmation?
    Then I should be on the project page
    And I should not see "First Project"
    And I should see "First Project deleted"
    
Scenario: Project managers (owners) can delete their own projects
    Given I am logged in as "Jason"
    And I am on the project page for "Second Project"
    When I press "delete_project"
    And I press "Yes" 
#confirmation?
    Then I should be on the project page
    And I should not see "First Project"
    And I should see "First Project deleted"
    
Scenario: Project managers (owners) cannot delete other projects
    Given I am logged in as "Linda"
    And I am on the project page for "Second Project"
    Then I should not see "delete_project"
    
Scenario: Collaborators cannot delete projects
    Given I am logged in as "Elise"
    And I am on the project page for "Second Project"
    Then I should not see "delete_project"

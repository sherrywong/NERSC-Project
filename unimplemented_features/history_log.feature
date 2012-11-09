Feature: Maintain history log of changes to projects/risks
	As a user,
	So that I can easily see and track changes made to projects,
	I want the history logs to only show actual modifications made to projects

Background: some projects and risks have already been added to database 
    Given I am logged in as an admin
    Given the following projects exist: 
    | name           | description | 
    | First Project  | proj1       |
    And I am on the project page 

Scenario: History log modified when project added
    Given I am logged in as an admin
    And I am on the project page
    When I go to the new project page
    When I fill in "project_name" with "Test Project" 
    When I fill in "project_description" with "Project 4"
    Then I press "Save" 
    Then I should be on the project page
    And I should see "Test Project"
    When I go to the history log for "Test Project"
    Then I should see "admin created 'Test Project' on date: "

Scenario: History log modified when project edited
    Given I am logged in as an admin
    When I go to project "Test Project"
    When I fill in "project_description" with "Test Project2"
    Then I press "Save"
    When I go to the history log for "Test Project"
    Then I should see "admin modified 'Test Project' description from 'Project 4' to 'Test Project2' on date: "

Scenario: History log modified and moved when project deleted
    Given I am logged in as an admin
    And I am on the project page
    And I click on delete project for "Test Project"
    And I should see "Project 'Test Project' deleted."
    Then I got to "Deleted projects and risks" page
    Then I should see "Test Project"
    When I go to the deleted "Test Project"'s history log page
    Then I should see "admin deleted 'Test Project' on date: "


Scenario: History log modified when risk added
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I fill in "risk_description" with "Our second risk for project 1."
    Then I press "Save"
    Then I should be on the Risk page for First Project
    Then I should see "Test Risk"
    When I go to the history log for "Test Risk"
    Then I should see "admin created 'Test Risk' on date: "
    
Scenario: History log modified when risk edited
    Given I am logged in as an admin
    When I go to the first project's Test Risk's Edit page
    When I fill in "risk_description" with "Description Changed"
    Then I press "Save"
    Then I should be on the first project's Risk page
    When I go to the history log for "Test Project"
    Then I should see "admin modified 'Test Project' description from 'Our second risk for project 1.' to 'Description Changed' on date: "

Scenario: History log modified and moved when project deleted
    Given I am logged in as an admin
    And I am on the first project's Risk page
    And I click on delete risk for "Test Risk"
    And I should see "Risk 'Test Risk' deactivated."
    Then I got to "Deleted projects and risks" page
    Then I should see "Test Risk"
    When I go to the deleted "Test Risk"'s history log page
    Then I should see "admin deleted 'Test Risk' on date: "
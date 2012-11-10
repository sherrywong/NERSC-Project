Feature: Create a project 
    As an administrator, 
    So that I can capture and share information about a project I am working on 
    I want to be able to create a project and share it with project members 
     
Background: some projects have already been added to database
    Given the following users exist:
    | username | email             | first  | last  | admin | password | status  |
    | admin    | admin@gmail.com   | admin  | admin | true  | admin    | active  |
    Given I am logged in as an admin
    Given the following projects exist: 
    | name           | description | 
    | First Project  | proj1       |  
    | Second Project | proj2       |  
    | Third Project  | proj3       |

Scenario: add valid project
    Given I am logged in as an admin
    And I am on the project page
    When I go to the new project page
    When I fill in "project_name" with "Test Project" 
    When I fill in "project_description" with "Project 4"
    Then I press "Save" 
    Then I should be on the project page
    And I should see "Project 'Test Project' created."
    And I should see "Test Project"

Scenario: edit project
    Given I am logged in as an admin
    When I go to the project page for "First Project"
    When I fill in "project_name" with "Test Project2"
    Then I press "Save"

Scenario: view a project that the user doesn't have read permissions
    Given I am logged in as an admin
    And I am on the project page
    When I go to the project page for "First Project"
#    Then I should see "Don't have permission to view this project."

Feature: Create a project 
    As an administrator, 
    So that I can capture and share information about a project I am working on 
    I want to be able to create a project and share it with project members 
     
Background: some projects have already been added to database 
     
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
    When I fill in "project_members" with "User1"
    Then I press "Save" 
    Then I should be on the project index page
    And I should see "Test Project"
 
Scenario: add project with missing fields
    Given I am logged in as an admin
    And I am on the project page
    When I go to the new project page 
    When I fill in "project_name" with "Test Title"
    When I fill in "project_description" with "Project 5"
    When I fill in "project_members" with "User2"
#    When I fill in "project_manager" with "Elise" 
#    Then I press "Save" 
#    Then I should be on the new project page 
#    And I should see "Error: missing fields" 
     
Scenario: add existing project
    Given I am logged in as an admin
    And I am on the project page 
    When I go to the new project page 
    When I fill in "project_name" with "First Project"
    When I fill in "project_description" with "Project 5"
    When I fill in "project_members" with "User3"
#    When I fill in "project_manager" with "Linda" 
#    When I fill in "risk_coords" with "Anna" 
#    When I fill in "proj_id" with 1 
#    When I fill in "dept" with "CS" 
#    Then I press "Save" 
#    Then I should be on the new project page 
#    And I should see "Error: Project already exists with that title."

Scenario: view a project that the user doesn't have read permissions
    Given I am logged in as an admin
    And I am on the project page
    When I go to the first project
#    Then I should see "Don't have permission to view this project."

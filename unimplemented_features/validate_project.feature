Feature: Validate a project 
    As a user,
    So that I can catch my own mistakes
    I want to be notified if a project is missing fields.
     
Background: some projects have already been added to database 
    Given I am logged in as an admin
    Given the following projects exist: 
    | name           | description | 
    | First Project  | proj1       |  
    | Second Project | proj2       |  
    | Third Project  | proj3       |

Scenario: Add project with missing fields
    And I am on the project page
    When I go to the new project page 
    #When I fill in "project_name" with "Test Title"
    When I fill in "project_description" with "Project 5"
#    When I fill in "project_members" with "User2"
#    When I fill in "project_manager" with "Elise" 
    Then I press "Save" 
    Then I should be on the new project page 
#    And I should see "Error: missing fields" 
     
Scenario: Add existing project
    And I am on the project page 
    When I go to the new project page 
    When I fill in "project_name" with "First Project"
    When I fill in "project_description" with "Project 5"
#    When I fill in "project_members" with "User3"
#    When I fill in "project_manager" with "Linda" 
#    When I fill in "risk_coords" with "Anna" 
#    When I fill in "proj_id" with 1 
#    When I fill in "dept" with "CS" 
    Then I press "Save" 
    Then I should be on the new project page 
    And I should see "Error: Project already exists with that name."

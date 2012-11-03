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
 
    And I am on the project page 
     
Scenario: add valid project 
    When I go to the new project page 
    Then I should be on the new project page 
    Then I fill in "project_name" with "Test Project" 
    Then I fill in "project_description" with "Project 4" 
    Then I press "Create" 
    Then I should be on the project index page
    And I should see "Test Project" 
 
#Scenario: add project with missing fields 
#    Given I press "new_proj" 
#    Then I set "proj_title" to "Test Title" 
#    Then I set "proj_manager" to "Elise" 
#    Then I press "create_proj" 
#    Then I should be on the create project page 
#    And I should see "Error: missing fields" 
     
#Scenario: add existing project 
#    Then I should be on the create project page 
#    Then I set "proj_title" to "First Project" 
#    Then I set "proj_manager" to "Linda" 
#    Then I set "risk_coords" to "Anna" 
#    Then I set "proj_id" to 1 
#    Then I set "dept" to "CS" 
#    Then I press "create_proj" 
#    Then I should be on the create project page 
#    And I should see "Error: Project already exists with that title."

#Scenario: view a project that the user doesn't have read permissions
#    Given I press "proj2"
#    Then I should see "Don't have permission to view this project."

Feature: Validate a project 
    As a user,
    So that I can catch my own mistakes
    I want to be notified if a project is missing fields.
     
Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Add project with missing fields
    And I am on the project page
    When I go to the new project page 
    #When I fill in "project_name" with "Test Title"
    When I fill in "project_description" with "Project 5"
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
#    When I fill in "dept" with "CS" 
    Then I press "Save" 
    Then I should be on the new project page 
#    And I should see "Error: Project already exists with that name."

Scenario: Set a user that doesn't exist as project owner. 
    And I am on the project page 
    When I go to the new project page 
    When I fill in "project_name" with "First Project"
    When I fill in "project_description" with "Project 5"
#    When I fill in "project_members" with "User3"
    When I fill in "project_owner_username" with "blah" 
#    When I fill in "risk_coords" with "Anna"
#    When I fill in "dept" with "CS" 
    Then I press "Save" 
    And I am on the project page

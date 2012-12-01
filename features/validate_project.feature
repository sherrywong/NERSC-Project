Feature: Validate a project 
    As a user,
    So that I can catch my own mistakes
    I want to be notified if a project is missing fields.
     
Background: Some projects have already been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
     
Scenario: Add a project that doesn't have a unique name.
    And I am on the home page 
    When I go to the new project page 
    When I fill in "project_name" with "First Project"
    When I fill in "project_description" with "Project 5"
    Then I press "Save" 
    Then I should be on the new project page 
    And I should see "Error: This project name already exists. Please use another name and try again."

Scenario: Set a user that doesn't exist as project owner. 
    And I am on the home page 
    When I go to the new project page 
    When I fill in "project_name" with "First Project"
    When I fill in "project_description" with "Project 5"
    When I fill in "project_owner_username" with "blah"
    Then I press "Save"
    And I am on the home page
    Then there should be this message: "Warning: User not found in database. Owner set to admin instead."

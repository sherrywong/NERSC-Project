Feature: Normalize flash messages
    As an admin,
    So that I can display all error messages
    I want to display all messages using flash and display the proper error message when generated.

Background: Some projects have already been added to database.
    Given the following users exist:
    | username  | email             | first       | last         | admin | password        |
    | admin     | admin@gmail.com   | admin       | admin        | true  | admin           |
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: view a project that the user doesn't have read permissions
    Given I am logged in as an admin
    And I am on the project page
    When I go to the project page for "First Project"
    Then I should see "Don't have permission to view this project."

Scenario: Add project with missing fields
    And I am on the project page
    When I go to the new project page
    When I fill in "project_description" with "Project 5"
    Then I press "Save" 
    Then I should be on the new project page 
    And I should see "Error: missing fields" 
     
Scenario: Add existing project
    And I am on the project page 
    When I go to the new project page 
    When I fill in "project_name" with "First Project"
    When I fill in "project_description" with "Project 5"
    Then I press "Save" 
    Then I should be on the new project page 
    And I should see "Error: Project already exists with that name."

Scenario: add risk with missing fields
    When I go to First Project's Add Risk page
    Then I fill in "risk_description" with "Risk 4" 
    Then I press "Save"
    Then I should be on First Project's Add Risk page 
    And I should see "Error: Missing field"
   
Scenario: Add risk to a project when user doesn't have permission to add risk
    When I go to Third Project's Add Risk page
    Then I should see "Error: Don't have permission to add risks to this project."

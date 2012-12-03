Feature: Manage project members 
    As an admin/project owner,
    So that I can manage who is on the project team and what they can do,
    I want to be able to add and remove members and manage their permissions. 
     
Background: Some users and projects have already been added to database
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist  

Scenario: Add a user to project as an admin.
    Given I am logged in as an admin
    When I go to the edit project page for "First Project"
    Then I press "+"
    When I fill in "members_" with "ag"
    And I press "Add"
    Then there should be this message: "All members added successfully."
    And I should be on the edit project page for "First Project"
    And I should see "ag"

Scenario: Remove a user from project as an admin.
    Given I am logged in as an admin
    When I go to the edit project page for "First Project"
    And I click on delete project member "ag" for "First Project"
    And I should be on the edit project page for "First Project"
    Then there should be this message: "Removed Anensshiya Govinthasamy from this project."

Scenario: Add invalid user to project as an admin.
    Given I am logged in as an admin
    When I go to the project page for "First Project"
    Then I press "+"
    When I fill in "members_" with "blah"
    And I press "Add"
    Then there should be this message: "Error: This person is not a current user."

Scenario: Add and delete user to project as a regular user
    Given I am logged in as Jason
    When I go to the edit project page for "First Project"
    Then I should see "Don't have permission to edit First Project."

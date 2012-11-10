Feature: Manage project members 
    As an admin/project owner,
    So that I can manage who is on the project team and what they can do,
    I want to be able to add and remove members and manage their permissions. 
     
Background: some users and projects have already been added to database
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist  

Scenario: Add and delete user to project as an admin
    Given I am logged in as an admin
    When I go to the project page for "First Project"
    Then I press "+"
    When I fill in "members_" with "bobw"
#    And I check "read" and "write"
    And I press "Add"
    Then I should see "Members updated."
    And I should be on the project page for "First Project"
    And I should see "bobw"
#    And I should see "Sherry Wong" as a project member with permissions "read" and "write"
    And I click on delete project member "bobw" for "First Project"
#    Then I should see "Are you sure you want to delete user: Sherry Wong from First Project?"
#    And I click "Yes"
#    And I should be on the first project
    Then I should not see "bobw"

Scenario: Add fake user to project as an admin
    Given I am logged in as an admin
    When I go to the project page for "First Project"
    Then I press "+"
    When I fill in "members_" with "blah"
    And I press "Add"
    Then I should see "Error: This person is not a current user."

#Scenario: add and delete user to project as a regular user
#    Given I am logged in as a user
#    When I go to the first project
#    Then I press "+"
#    Then I should see "Don't have permission to add user to First Project."
#    Given I click on "Delete user" for Sherry Wong
#    Then I should see "Don't have permission to delete Sherry Wong from First Project." 

#Scenario: change user read/write permissions of a project as an admin
#    Given I am logged in as an admin
#    When I go to the first project
#    And I see "Sherry Wong" as a user associated with "First Project"
#    And "Sherry Wong" as "read" and "write" permissions
#    And I click "Manage user permissions"
#    Then I uncheck "write" permission for "Sherry Wong"
#    And I press "Add"
#    Then I should be on the "First Project" page
#    And "Sherry Wong" has "read" permission

#Scenario: remove read and write permissions of a user
#    Given I am logged in as a user
#    When I go to the first project
#    And I see "Sherry Wong" as a user associated with "First Project"
#    And "Sherry Wong" as "read" and "write" permissions
#    And I click "Manage user permissions"
#    And I uncheck "write" and "read" permissions for "Sherry Wong"
#    And I press "Add"
#    Then I should see "Cannot uncheck read and write permissions. Delete user from project if this is what you intended."
#    And I click "Cancel"
#    Then I should be on the "First Project" page
#    And "Sherry Wong" has "read" and "write" permission
#    And I click "Manage user permissions"
#    And I uncheck "read" permissions for "Sherry Wong"
#    And I press "Add"
#    Then I should see "Cannot uncheck read permission when write permission is enabled."

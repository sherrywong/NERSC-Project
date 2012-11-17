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
    And I should be on the project page for "First Project"
    Then there should be this message: "Members updated."
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
    Then there should be this message: "Error: This person is not a current user."

#Scenario: add and delete user to project as a regular user
#    Given I am logged in as a user
#    When I go to the first project
#    Then I press "+"
#    Then I should see "Don't have permission to add user to First Project."
#    Given I click on "Delete user" for Sherry Wong
#    Then I should see "Don't have permission to delete Sherry Wong from First Project."

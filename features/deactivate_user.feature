Feature: Manage users
    As an admin,
    So that I can change access capability to the database,
    I want to be able to delete users.

Background: Some user logins exist.
    Given a set of users exist   
    And I am logged in as an admin

Scenario: Deactivate a user and should not be able to edit retired user.
    When I am on the project page
    And I go to the show users page
    And I click on deactivate user for "bobw"
#    And I should see "Are you sure you want to delete user "Bob" from system users?"
#    And I click "Yes"
    Then there should be this message: "User deactivated."
    And "Sherry Wong" should be retired
    When I go to bobw's Edit User page
    Then I should not see "Save"

Scenario: Cannot deactivate admin.
    When I am on the project page
    And I go to the show users page
    And I click on deactivate user for "admin"
#    And I should see "Are you sure you want to delete user "Bob" from system users?"
#    And I click "Yes"
    Then there should be this message: "You cannot deactivate this user."

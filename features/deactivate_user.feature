Feature: Manage users
    As an admin,
    So that I can change access capability to the database,
    I want to be able to delete users.

Background: Some user logins exist.
    Given a set of users exist

Scenario: Admin can deactivate a user.
    Given I am logged in as an admin
    And I go to the show users page
    And I click on deactivate user for "bobw"
#    And I should see "Are you sure you want to delete user "Bob" from system users?"
#    And I click "Yes"
    Then there should be this message: "User deactivated."
    And "Sherry Wong" should be retired
    Then there should not be deactivate user for "Sherry"

Scenario: Admin cannot deactivate admin.
    Given I am logged in as an admin
    And I go to the show users page
    And I click on deactivate user for "admin"
#    And I should see "Are you sure you want to delete user "Bob" from system users?"
#    And I click "Yes"
    Then there should be this message: "You cannot deactivate this user."

Scenario: Non-admin cannot deactivate users.
    Given I am logged in as Jason
    And I click on deactivate user for "ag"
#    And I should see "Are you sure you want to delete user "Bob" from system users?"
#    And I click "Yes"
    Then there should be this message: "Sorry, you have to be an admin to perform this action."

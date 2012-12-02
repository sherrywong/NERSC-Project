Feature: Change status of users
    As an admin,
    So that I can change access capability to the database,
    I want to be able to deactivate/activate users.

Background: Some user logins exist.
    Given a set of users exist

Scenario: Admin can deactivate or reactivate a user.
    Given I am logged in as an admin
    And I go to the show users page
    And I click on deactivate user for "bobw"
    Then there should be this message: "User deactivated."
    Then there should not be deactivate "user" for "Sherry"
    And I click on reactivate user for "bobw"
    Then there should be this message: "User reactivated."
    Then there should not be reactivate "user" for "Sherry"

Scenario: Admin cannot deactivate admin.
    Given I am logged in as an admin
    And I go to the show users page
    And I click on deactivate user for "admin"
    Then there should be this message: "You cannot deactivate this user."
    And I click on reactivate user for "admin"
    Then there should be this message: "You cannot reactivate this user."

Scenario: Non-admin cannot deactivate users.
    Given I am logged in as Jason
    And I click on deactivate user for "ag"
    Then there should be this message: "Sorry, you have to be an admin to perform this action."
    And I click on reactivate user for "ag"
    Then there should be this message: "Sorry, you have to be an admin to perform this action."

Feature: Add users
    As an admin,
    So that I can manage who has access to the database,
    I want to be able to add, edit, and delete users.

Background: Some user logins exist.
    Given a set of users exist

Scenario: Admin can create a user.
    Given I am logged in as an admin
    And I go to the show users page
    And I go to the Add New User page
    And I fill in "user_username" with "Starfish"
    And I fill in "user_email" with "a.a@gmail.com"
    And I fill in "user_first" with "Temp"
    And I fill in "user_last" with "User"
    And I fill in "user_admin" with "false"
    And I fill in "user_password" with "tu"
    And I press "Save"
    Then I should be on the show users page
    Then there should be this message: "User 'Temp User' created."
    And I should see "Starfish"

Scenario: Non-admin cannot create a user.
    Given I am logged in as Jason
    And I go to the Add New User page
    Then I should see "Sorry, you have to be an admin to perform this action."

Scenario: Admin can edit a user.
   Given I am logged in as an admin
   When I go to ag's Edit User page
   And I fill in "user_first" with "Sherry"
   And I press "Save"

Scenario: Admin cannot edit a retired user.
    Given I am logged in as an admin
    And I go to the show users page
    When I go to em's Edit User page
    Then I should not see "Save"

Scenario: Non-admin cannot edit a user.
   Given I am logged in as Jason
   When I go to ag's Edit User page
   Then I should see "Sorry, you have to be an admin to perform this action."
   Then I should see "User Sherry Govinthasamy was successfully updated."

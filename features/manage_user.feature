Feature: Manage users
    As an admin,
    So that I can manage who has access to the database,
    I want to be able to add, edit, and delete users.

Background: Some user logins exist.
    Given a set of users exist
    And I am logged in as an admin

Scenario: Create a user as an admin.
    When I go to the project page
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

Scenario: Edit a user.
   When I go to ag's Edit User page
   And I fill in "user_first" with "Sherry"
   And I press "Save" 
   Then I should see "User Sherry Govinthasamy was successfully updated."

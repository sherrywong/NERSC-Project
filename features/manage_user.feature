Feature: Manage users
    As an admin,
    So that I can manage who has access to the database,
    I want to be able to add, edit, and delete users.

Background: Some user logins exist.
    Given a set of users exist
    And I am logged in as an admin

Scenario: Create a user.
    When I go to the project page
    And I go to the show users page
    Then I sort users by "username"
    Then I sort users by "first"
    Then I sort users by "last"
    Then I sort users by "email"
    Then I sort users by "status"
    And I go to the Add New User page
    And I fill in "user_username" with "Starfish"
    And I fill in "user_email" with "zhang.lynda@gmail.com"
    And I fill in "user_first" with "Linda"
    And I fill in "user_last" with "Zhang"
    #And I fill in "admin" with "false"
    And I fill in "user_password" with "lZhang"
    And I press "Save"
    Then I should be on the show users page
    #Then I should see "User created."
    And I should see "Starfish"

Scenario: Edit a user.
   When I go to ag's Edit User page
   And I fill in "user_first" with "Sherry"
   And I press "Save" 
   Then I should see "User Sherry Govinthasamy was successfully updated."

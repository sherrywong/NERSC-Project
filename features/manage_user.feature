Feature: Manage users
    As an admin,
    So that I can manage who has access to the database,
    I want to be able to add, edit, and delete users.

Background: Some user logins exist.
    Given the following users exist:
    | username | email             | first      | last         | admin | password        |
    | ag       | anna@gmail.com    | Anensshiya | Govinthasamy | true  | agovinthasamy   |
    | sw       | bob@gmail.com     | Sherry     | Wong         | true  | swong           |
   
    And I am logged in as an admin

Scenario: create
    When I go to the project page
    And I go to the show users page
    And I follow "Add new user"
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

Scenario: edit
   When I go to anna's Edit User page
   And I fill in "user_first" with "Sherry"
   And I press "Save" 
   Then I should see "User Sherry Govinthasamy was successfully updated."


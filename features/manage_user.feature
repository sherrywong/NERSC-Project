Feature: Manage users
    As an admin,
    So that I can manage who has access to the database,
    I want to be able to add, edit, and delete users.

Background: Some user logins exist.
    Given the following users exist:
    | username  | email             | first       | last          | admin | password        |
    | anna      | anna@gmail.com    | Anensshiya  | Govinthasamy | true  | agovinthasamy   |
    | bob       | bob@gmail.com     | Shery       | Wong         | true  | swong           |
   
    And I am logged in as an admin

Scenario:
    When I go to the project page
    And I click on "Add Users"
    And I fill in "username" with "Starfish"
    And I fill in "email" with "zhang.lynda@gmail.com"
    And I fill in "first" with "Linda"
    And I fill in "last" with "Zhang"
    And I fill in "admin" with "false"
    And I fill in "password" with "lZhang"
    And I press "Submit"
    Then I should see "User Linda Zhang created."
    And I should see "Linda Zhang"

    When I go to "anna's Edit Users" page
    And I fill in "first" with "Sherry"
    And I press "Submit" 
    Then I should see "User Sherry Govinthasamy was successfully updated."

    When I am on the project page
    And I press "Manage System Users"
    And I click on "delete" for "bob"
    Then I should see "User Sherry Wong deleted."
    And I should not see "Sherry Wong"

    
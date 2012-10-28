Feature: Manage users
    As an admin,
    So that I can change access capability to the database,
    I want to be able to delete users.

Background: Some user logins exist.
    Given the following users exist:
    | username  | email             | first       | last         | admin | password        |
    | anna      | anna@gmail.com    | Anensshiya  | Govinthasamy | true  | agovinthasamy   |
    | bob       | bob@gmail.com     | Shery       | Wong         | true  | swong           |
   
    And I am logged in as an admin

Scenario: Delete a user
    When I am on the project page
    And I press "Manage System Users"
    And I click on "delete" for "bob"
	 Then I should see "Are you sure you want to delete user "Bob" from system users?"
	 And I click "Yes"
    Then I should see "User Sherry Wong deleted."
    And I should not see "Sherry Wong"
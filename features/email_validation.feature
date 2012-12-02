Feature: Validate Email
    As a user or admin,
    So that I am sure that a user is not spam,
    I want to be able to make sure that a user signs up with a valid email address.

Background: Some user logins exist.
    Given a set of users exist

Scenario: Cannot add a user if the user email address is invalid
    Given I am logged in as an admin
    And I go to the show users page
    And I go to the Add New User page
    And I fill in "user_username" with "Starfish"
    And I fill in "user_email" with "a.agmail.com"
    And I fill in "user_first" with "Temp"
    And I fill in "user_last" with "User"
    And I select "False" from "user[admin]"
    And I fill in "user_password" with "tu"
    And I press "Save"
    Then I should be on the show users page
    And I should see "Error occured when trying to create this user. Please make sure you have entered a valid email address and the username has not been taken."    

Scenario: Can add a user with a valid email address
    Given I am logged in as an admin
    And I go to the show users page
    And I go to the Add New User page
    And I fill in "user_username" with "Starfish"
    And I fill in "user_email" with "a.agmail.com"
    And I fill in "user_first" with "Temp"
    And I fill in "user_last" with "User"
    And I select "False" from "user[admin]"
    And I fill in "user_password" with "tu"
    And I press "Save"
    Then I should be on the show users page
    Then there should be this message: "User 'Temp User' created."


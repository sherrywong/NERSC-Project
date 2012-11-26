Feature: Change own profile information
    As a user,
    So that I can edit my personal information,
    I want to be able to update my user information

Background: Some user logins exist.
    Given a set of users exist

Scenario: Users can edit their own profile information.
    Given I am logged in as Jason
    And I go to the My Profile page for "Jason"
    And I fill in "user_first" with "Sherry"
    And I press "Save"
    Then I should be on the project page
    Then I should see "User Sherry Teoh was successfully updated."

Scenario: User cannot edit their username.
   Given I am logged in as Jason
   And I go to the My Profile page for "Jason"
   Then I should not be able to fill in "user_username"

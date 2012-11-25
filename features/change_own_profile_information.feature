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
    Then I should see "Profile Information updated."

Scenario: User cannot edit their username.
   Given I am logged in as Jason
   And I go to the My Profile page for "Jason"
   Then I should not be able to fill in "user_username"

Scenario: Users can change their password.
    Given I am logged in as Jason
    And I go to the My Profile page for "Jason"
    And I go to the Change Password page
    Then I should see "Old Password"
    Then I should see "New Password"
    Then I should see "Confirm New Password"
    And I fill in "old_password" with "jteoh"
    And I fill in "new_password" with "jt"
    And I fill in "confirm_new_password" with "jt"
    And I press "Save"
    Then I should be on the My Profile page for "Jason"
    Then I should see "Profile Information updated."

Scenario: Incorrect old password.
    Given I am logged in as Jason
    And I go to the My Profile page for "Jason"
    And I go to the Change Password page
    And I fill in "old_password" with "zzzz"
    And I fill in "new_password" with "jt"
    And I fill in "confirm_new_password" with "jt"
    And I press "Save"
    Then I should be on the Change Password page
    Then I should see "Old password incorrect."
    And I fill in "old_password" with "zzzz"
    And I fill in "new_password" with "jt"
    And I fill in "confirm_new_password" with "jz"
    And I press "Save"
    Then I should be on the Change Password page
    Then I should see "New password does not match."
    And I fill in "old_password" with "jteoh"
    And I fill in "new_password" with "jt"
    And I fill in "confirm_new_password" with "jt"
    And I press "Save"
    Then I should be on the My Profile page for "Jason"
    Then I should see "Profile Information updated."


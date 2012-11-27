Feature: Password Reset
    As a user,
    So that I can still access my account after forgetting my password.
    I want to be able to reset my password.

Background: Some user logins exist.
    Given a set of users exist

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
    Then I should be on the project page
    Then I should see "User Jason Teoh was successfully updated."

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
    Then I should be on the project page
    Then I should see "Profile Information updated."
Feature: User login 
    As a user,
    So that only I can access my project information,
    I want to be able to log in and out of the system.
    
Background: Some user logins exist.
    Given a set of users exist
    And I am not logged in
    
Scenario: Require login.
    When I go to the home page
    And I should not see "My Projects"
    And I should see "Login"

Scenario: Deactivated user sign-in
   When I go to the login page
   And I fill in "username" with "em"
   And I fill in "password" with "emccallum"
   And I press "Login"
   Then I should be on the login page
   Then I should see "Your account has been deactivated."

Scenario: valid login
    When I go to the login page
    And I fill in "username" with "ag"
    And I fill in "password" with "agovinthasamy"
    And I press "Login"
    Then I should be on the home page
    
Scenario: invalid login - bad password
    When I go to the login page
    And I fill in "username" with "ag"
    And I fill in "password" with "swong"
    And I press "Login"
    Then I should be on the login page
    And I should see "Incorrect password."
    
Scenario: invalid login - username nonexistent
    When I go to the login page
    And I fill in "username" with "starfish"
    And I fill in "password" with "swong"
    And I press "Login"
    Then I should be on the login page
    And I should see "We don't have a user by this username."
    
Scenario: after logout should require login access
    Given I am logged in as an admin
    And I log out
    And I go to the home page
    Then I should not see "My Projects"
    And I should be on the login page

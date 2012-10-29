Feature: User login 
    As a user,
    So that only I can access my project information,
    I want to be able to log in and out of the system.
    
Background: Some user logins exist.
    Given the following users exist:
    | username  | email             | first       | last         | admin | password        | status  |
    | anna      | anna@gmail.com    | Anensshiya  | Govinthasamy | true  | agovinthasamy   | active  |
    | bob       | bob@gmail.com     | Shery       | Wong         | true  | swong           | retired |
    | elise     | elise@gmail.com   | Elise       | McCallum     | false | emccallum       | active  |
    | jason     | jason@gmail.com   | Jia         | Teoh         | false | jteoh           | active  |
    | linda     | linda@gmail.com   | Lingbo      | Zhang        | false | lzhang          | active  |
    
    And I am not logged in
    
Scenario: require login
    When I go to the project page
    And I should not see "My Projects"
    And I should see "Login"

Scenario: deactivated user sign-in
   When I go to the login page
   And I fill in "username" with "bob"
   And I fill in "password" with "swong"
   Then I should see "Your account has been deactivated." 

Scenario: valid login
    When I go to the login page
    And I fill in "username" with "anna"
    And I fill in "password" with "agovinthasamy"
    And I press "Login"
    Then I should be on the project page
    
Scenario: invalid login - bad password
    When I go to the login page
    And I fill in "username" with "anna"
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
    Given I am logged in
    And I log out
    And I go to the project page
    Then I should not see "My Projects"
    And I should be on the login page

Feature: User security
    As a user,
    So that my project information is secure,
    I want to be able to log in and out of the system.
    
Background: Some user logins exist.
    Given the following users exist:
    | username  | email             | first       | last          | admin | password        |
    | anna      | anna@gmail.com    | Anensshiya  | Govinthasamy | true  | agovinthasamy   |
    | bob       | bob@gmail.com     | Shery       | Wong         | true  | swong           |
    | elise     | elise@gmail.com   | Elise       | McCallum     | false | emccallum       |
    | jason     | jason@gmail.com   | Jia         | Teoh         | false | jteoh           |
    | linda     | linda@gmail.com   | Lingbo      | Zhang        | false | lzhang          |
    
    And I am not logged in
    
Scenario: require login
    When I go to the project page
    I should not see "My Projects"
    And I should see "Login"
    
Scenario: valid login
    When I go to the login page
    And I fill in "username" with "anna"
    And I fill in password with "agovinthasamy"
    And I press "Sign in"
    Then I should be on the project page
    
Scenario: invalid login
    When I go to the login page
    And I fill in "username" with "anna"
    And I fill in password with "swong"
    And I press "Sign in"
    Then I should I should be on the login page
    And I should see "We don't have a user by this username."

Scenario: logout should require login access
    Given I am logged in
    When I press "logout"
    And I go to the project page
    Then I should not see "My Projects"
    And I should be on the login page
Feature: Breadcrumb trail 
    As a user,
    So that I know how I got to the current page,
    I want to see what pages that I clicked on before. 
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
	
Scenario: Go through series of pages dealing with users as an admin.
    Given I am logged in as an admin
    Then I should be on the home page
    When I press "+ Manage System Users"
    When I press "+ Add new user"
    When I follow "Users"
    Then I should be on the show users page
    When I follow "ag"
    When I follow "Users"
    Then I should be on the show users page
    When I follow "Home"
    Then I should be on the home page
    When I press "My Profile"
    When I follow "Home"
    Then I should be on the home page

Scenario: Go through series of pages dealing with users as a user.
    Given I am logged in as Jason
    Then I should be on the home page
    When I press "My Profile"
    Then I should not see "Users"
    When I follow "Home"
    Then I should be on the home page

Scenario: Go through series of pages dealing with projects.
    Given I am logged in as an admin
    Then I should be on the home page
    When I press "+ Create New Project"
    When I follow "Home"
    Then I should be on the home page
    When I follow "First Project"
    When I follow "Home"
    Then I should be on the home page

Scenario: Go through series of pages dealing with risks.
    Given I am logged in as an admin
    Then I should be on the home page
    When I follow "First Project"
    Then I should be on the project page for "First Project"
    When I press "+ Edit Project"
    Then I should be on the edit project page for "First Project"
    When I follow "First Project"
    Then I should be on the project page for "First Project"
    When I press "+ Create New Risk"
    When I follow "Risks"
    Then I should be on the risk index page for First Project
    When I press "+ Create New Risk"
    When I follow "First Project"
    Then I should be on the project page for "First Project"
    When I press "+ Display Associated Risks"
    When I follow "First Project"
    Then I should be on the project page for "First Project"

Feature: Breadcrumb trail 
    As a user,
    So that I know how I got to the current page,
    I want to see what pages that I clicked on before. 
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist
	
Scenario: Go through series of pages dealing with users.
    Given I am logged in as an admin
    Then I should be on the project page
    When I press "+ Manage System Users"
    When I press "+ Add new user"
    When I follow "Users"
    Then I should be on the show users page
    When I follow "ag"
    When I follow "Users"
    Then I should be on the show users page
    When I follow "Home"
    Then I should be on the project page
    When I press "+ Edit My Profile"
    When I follow "Home"
    Then I should be on the project page

Scenario: Go through series of pages dealing with projects.
    Given I am logged in as an admin
    Then I should be on the project page
    When I press "+ Create New Project"
    When I follow "Home"
    Then I should be on the project page
    When I follow "First Project"
    When I follow "Home"
    Then I should be on the project page

Scenario: Go through series of pages dealing with risks.
    Given I am logged in as an admin
    Then I should be on the project page
    When I follow "First Project"
    Then I should be on the project page for "First Project"
    When I press "+ Add New Risk"
    When I follow "Risks"
    Then I should be on the risk index page for First Project
    When I press "+ Create New Risk"
    When I follow "First Project"
    Then I should be on the project page for "First Project"
    When I press "+ Display Associated Risks"
    When I follow "First Project"
    Then I should be on the project page for "First Project"
    When I follow "Home"
    Then I should be on the project page


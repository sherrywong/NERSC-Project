Feature: Breadcrumb trail 
    As a user,
    So that I know how I got to the current page,
    I want to see what pages that I clicked on before. 
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist
	
Scenario: Go through series of pages.
    Given I am logged in as an admin
    Then I should be on the project page
    And I go to the show users page
    Then I should see "Index -> Show Users"
    And I go to the Add New User page
    Then I should see "Index -> Show Users -> Add User"
    Then I click "Show Users"
    Then I should be on the show users page
    Then I should see "Index -> Show Users"
    Then I click "Index"
    Then I should be on the project page

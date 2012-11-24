Feature: Reassignment of project/risk owners.
    As a user,
    So that I know how I got to the current page,
    I want to see what pages that I clicked on before. 
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist
	
Scenario: Admin deals with a deactivated project manager.
    Given I am logged in as an admin
    Then I go to the show users page
    And I click on deactivate user for "jt"
    Then there should be this message: "User deactivated."
    And "Jason Teoh" should be retired
    Then I go to the project page
    Then I should see "Reassign Owners"
    Then I go to the reassign page
    Then I should see "Second Project"
    When I go to the project page for "Second Project"
    Then I should see "admin" for "project_owner_username"
    When I fill in "project_owner_username" with "ag"
    Then I press "Save"
    Then I should be on the project page for "Second Project"
    Then I go to the reassign page
    Then I should not see "Second Project"

Scenario: Admin deals with a deactivated risk owner.
    Given I am logged in as an admin
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    Then I should see "Short Title"
    When I fill in "risk_owner_id" with "lz"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for First Project
    Then there should be this message: "Risk 'Test Risk' created."
    Then I go to the show users page
    And I click on deactivate user for "lz"
    Then there should be this message: "User deactivated."
    And "Linda Zhang" should be retired
    Then I go to the reassign page
    Then I should see "First Project"
    When I go to the project page for "First Project"
    Then I should see "admin" for "project_owner_username"
    When I fill in "project_owner_username" with "ag"
    Then I press "Save"
    Then I should be on the project page for "First Project"
    Then I go to the reassign page
    Then I should not see "First Project"

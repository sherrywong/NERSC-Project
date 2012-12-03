Feature: Risk comment history
	As a project member,
	So I can track notes associated to a project risk,
	I want to be able to see a date-sort comment log. 
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist
	
Scenario: Admins can add and edit a valid risk.
    Given I am logged in as an admin
    And I am on the home page
    When I follow "First Project"
    And I am on the project page for "First Project"
    When I press "+ Add New Risk"
    When I fill in "risk_title" with "Test Risk"
    When I select "admin" from "risk[owner_id]"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    When I fill in "risk_comment" with "Risk created"
    Then I press "Save"
    Then I should be on the risk index page for First Project
    Then there should be this message: "Risk 'Test Risk' created."
    When I follow "Add comment"
    Then I fill in "risk_comment" with "Risk being controlled."
    Then I press "Save"
    Then I should be on the risk page for "Test Risk"
    Then I should see comment "Risk created"
    Then I should see comment "Test Risk"

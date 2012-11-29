Feature: Risk Report (Track changes to a risk)
	As an admin or project member,
	So that I can have a measure of how effective the risk actions are
	I want to be able to track a specific risk before and after risk actions are taken
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist
    
Scenario: Expand risks to see full report
	Given that I am logged in as admin
	Then I follow "First Project"
	Then I follow "+ Display Associated Risks"
	Then I should see 4 risks ass
	Given I expand "First Risk"
	Then I should see all the details for "First Risk"
	Given I expand "Second Risk"
	Then I should see all the details for "Second Risk"
	Given I expand "Third Risk"
	Then I should see all the details for "Third Risk"
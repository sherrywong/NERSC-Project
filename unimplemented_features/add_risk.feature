Feature: Create a risk
	As a project member,
	So that I can capture risk associated with a particular project,
	I want to be able to document the specifics of the risk and add it to the risk log.
	
Background: some projects and no risks have been added to database
	
	Given the following projects exist:
	| name           | description | 
        | First Project  | proj1       |  
        | Second Project | proj2       |  
        | Third Project  | proj3       |  
 
    And I am on the project page 
	
Scenario: add valid risk
	Given I press "First Project"
	Then I should be on the create risk page
        And I press "Create new risk"
	Then I set "risk_title" to "Test Risk"
	Then I set "risk_originator" to "Linda"
	Then I set "risk_owner" to "Linda"
	Then I set "risk_desc" to "Our second risk for project 1."
	Then I set "risk_date" to "02-12-2012"
	Then I press "Create Risk"
	Then I should be on the risk page for "First Project"
	And I should see "Test Risk"

Scenario: add risk with missing fields
	Given I press "new_risk"
	Then I set "risk_title" to "Test Risk"
	Then I set "risk_owner" to "Elise"
	Then I press "create_risk"
	Then I should be on the create risk page for "First Project"
	And I should see "Error: missing fields"
	
Scenario: add existing risk
	Then I should be on the create project page
	Then I set "risk_title" to "First Risk"
	Then I set "risk_originator" to "Linda"
	Then I set "risk_owner" to "Anna"
	Then I set "risk_desc" to "Our first risk for project 1."
	Then I set "risk_date" to "02-11-2012"
	Then I press "create_risk"
	Then I should be on the create risk page for "First Project"
	And I should see "Error: Risk already exists with that title."

Scenario: View a risk that the user doesn't have read permission
    Given I go to Project named "Second Project"
    And I go to the manage risk page 
    Then I should see "Error: Don't have permission to view the risks associated with this project."
    
Scenario: Add risk to a project when user doesn't have permission to add risk
    Given I go to Project named "Third Project"
    And I go to the manage risk page
    And I click "Create New Risk"
    Then I should see "Error: Don't have permission to add risks to this project."
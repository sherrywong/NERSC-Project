Feature: Create a risk
	As a project member,
	So that I can capture risk associated with a particular project,
	I want to be able to document the specifics of the risk and add it to the risk log.
	
Background: some projects and risks have already been added to database
	
	Given the following projects exist:
	| title          | manager | coordinators  | project_id | department | start      | end         |
	| First Project  | Linda   | Anna		   | 1          | CS		 | 02-10-2012 | 05-10-2012  |
	| Second Project | Jason   | Elise, Sherry | 2          | CS	     | 03-10-2012 | 06-10-2012  |
	| Third Project  | Anna    | Sherry        | 3          | Art        | 04-10-2012 | 07-10-2012  |
    
	And the following risks exist:
	| title       | project        | risk_id | originator | owner  | description                   | id_date    |
	| First Risk  | First Project  | 1-1     | Linda      | Anna   | Our first risk for project 1. | 02-11-2012 |
	| Second Risk | Second Project | 2-1     | Jason      | Elise  | Our first risk for project 2. | 03-11-2012 |
	| Third Risk  | Third Project  | 3-1     | Anna       | Sherry | Our first risk for project 3. | 04-11-2012 |
	
	And I am on the risk page for "First Project"
	
Scenario: add valid risk
	Given I press "new_risk"
	Then I should be on the create risk page
	Then I set "risk_title" to "Test Risk"
	Then I set "risk_originator" to "Linda"
	Then I set "risk_owner" to "Linda"
	Then I set "risk_desc" to "Our second risk for project 1."
	Then I set "risk_date" to "02-12-2012"
	Then I press "create_risk"
	Then I should be on the risk page for "First Project"
	And I should see "Test Risk" after "First Risk"

Scenario: add risk with missing fields
	Given I press "new_risk"
	Then I set "risk_title" to "Test Risk"
	Then I set "risk_owner" to "Elise"
	Then I press "create_risk"
	Then I should be on the create risk page
	And I should see "Error: missing fields"
	
Scenario: add existing risk
	Then I should be on the create project page
	Then I set "risk_title" to "First Risk"
	Then I set "risk_originator" to "Linda"
	Then I set "risk_owner" to "Anna"
	Then I set "risk_desc" to "Our first risk for project 1."
	Then I set "risk_date" to "02-11-2012"
	Then I press "create_risk"
	Then I should be on the create project page
	And I should see "Error: Risk already exists with that title."
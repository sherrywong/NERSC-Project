Feature: Create a project
	As an administrator,
	So that I can capture and share information about a project I am working on
	I want to be able to create a project and share it with project members
	
Background: some projects have already been added to database
	
	Given the following projects exist:
	| title          | manager | coordinators  | id | department | start      | end
	| First Project  | Linda   | Anna	       | 1  | CS		 | 02-10-2012 | 05-10-2012
	| Second Project | Jason   | Elise, Sherry | 2  | CS	     | 03-10-2012 | 06-10-2012
	| Third Project  | Anna    | Sherry        | 3  | Art        | 04-10-2012 | 07-10-2012
	
	And I am on the project page
	
Scenario: add valid project
	Given I press "new_proj"
	Then I should be on the create project page
	Then I set "proj_title" to "Test Project"
	Then I set "proj_manager" to "Elise"
	Then I set "risk_coords" to "sherry, jason"
	Then I set "proj_id" to 9
	Then I set "dept" to "CS"
	Then I press "create_proj"
	Then I should be on the project page
	And I should see "Test Project" after "First Project"

Scenario: add project with missing fields
	Given I press "new_proj"
	Then I set "proj_title" to "Test Title"
	Then I set "proj_manager" to "Elise"
	Then I press "create_proj"
	Then I should be on the create project page
	And I should see "Error: missing fields"
	
Scenario: add existing project
	Then I should be on the create project page
	Then I set "proj_title" to "First Project"
	Then I set "proj_manager" to "Linda"
	Then I set "risk_coords" to "Anna"
	Then I set "proj_id" to 1
	Then I set "dept" to "CS"
	Then I press "create_proj"
	Then I should be on the create project page
	And I should see "Error: Project already exists with that title."
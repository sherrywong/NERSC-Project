Feature: Delete a project
    As a project owner or admin,
    So that I can remove completed projects from the system
    I want to be able to delete projects
    
Background: some projects and risks are already in the database.
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
	
    
Scenario: Admins can delete
    Given I am logged in as an admin
    And I am on the project page for "Second Project"
    When I press "delete_project"
    And I press "Yes" #confirmation?
    Then I should be on the project page
    And I should not see "First Project"
    And I should see "First Project deleted"
    
Scenario: Project managers (owners) can delete their own projects
    Given I am logged in as "Jason"
    And I am on the project page for "Second Project"
    When I press "delete_project"
    And I press "Yes" #confirmation?
    Then I should be on the project page
    And I should not see "First Project"
    And I should see "First Project deleted"
    
Scenario: Project managers (owners) cannot delete other projects
    Given I am logged in as "Linda"
    And I am on the project page for "Second Project"
    Then I should not see "delete_project"
    
Scenario: Collaborators cannot delete projects
    Given I am logged in as "Elise"
    And I am on the project page for "Second Project"
    Then I should not see "delete_project"
    
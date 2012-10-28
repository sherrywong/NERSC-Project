Feature: Manage project members 
    As an admin/project owner,
	So that I can manage who is on the project team and what they can do,
	I want to be able to add and remove members and manage their permissions. 
     
Background: some users and projects have already been added to database 
    Given the following users exist:
    | username  | email             | first       | last         | admin | password        |
    | anna      | anna@gmail.com    | Anensshiya  | Govinthasamy | true  | agovinthasamy   |
    | bob       | bob@gmail.com     | Shery       | Wong         | true  | swong           |
    | elise     | elise@gmail.com   | Elise       | McCallum     | false | emccallum       |
    | jason     | jason@gmail.com   | Jia         | Teoh         | false | jteoh           |
    | linda     | linda@gmail.com   | Lingbo      | Zhang        | false | lzhang          |

	Given the following projects exist: 
    | name           | description | 
    | First Project  | proj1       |  
    | Second Project | proj2       |  
    | Third Project  | proj3       |  

Scenario: add and delete user to project as an admin
    Given I am logged in as an admin
    And I click "First Project"
    And I click "Add Project Member"
    And I select "Sherry Wong"
    And I check "read" and "write"
    And I click "Submit"
    Then I should see "User Sherry Wong add to First Project."
    And I should be on the "First Project" page
    And I should see "Sherry Wong" as a project member with permissions "read" and "write"
    Given I click on "Delete user" for Sherry Wong
    Then I should see "Are you sure you want to delete user: Sherry Wong from First Project?"
    And I click "Yes"
    Then I should see "User Sherry Wong deleted from First Project."
    And I should be on the "First Project" page
    And I should not see "Sherry Wong" as a project member
    
Scenario: add and delete user to project as a project manager
    Given I am logged in as a project manager
    And I click "First Project"
    And I click "Add Project Member"
    And I select "Sherry Wong"
    And I check "read"
    And I click "Submit"
    Then I should see "User Sherry Wong add to First Project."
    And I should be on the "First Project" page
    And I should see "Sherry Wong" as a project member with permissions "read"
    Given I click on "Delete user" for Sherry Wong
    Then I should see "Are you sure you want to delete user: Sherry Wong from First Project?"
    And I click "Yes"
    Then I should see "User Sherry Wong deleted from First Project."
    And I should be on the "First Project" page
    And I should not see "Sherry Wong" as a project member
    
Scenario: add and delete user to project as a regular user
    Given I am logged in as a user
    And I click "First Project"
    And I click "Add Project Member"
    Then I should see "Don't have permission to add user to First Project."
    Given I click on "Delete user" for Sherry Wong
    Then I should see "Don't have permission to delete Sherry Wong from First Project?" 

Scenario: change user read/write permissions of a project as an admin
	Given I am logged in as an admin
	And I click "First Project"
	And I see "Sherry Wong" as a user associated with "First Project"
	And "Sherry Wong" as "read" and "write" permissions
	And I click "Manage user permissions"
	Then I uncheck "write" permission for "Sherry Wong"
	And I click "Submit"
	Then I should be on the "First Project" page
	And "Sherry Wong" has "read" permission

Scenario: remove read and write permissions of a user on a project as an project manager
	Given I am logged in as an project manager
	And I click "First Project"
	And I see "Sherry Wong" as a user associated with "First Project"
	And "Sherry Wong" as "read" and "write" permissions
	And I click "Manage user permissions"
	And I uncheck "write" and "read" permissions for "Sherry Wong"
	And I click "Submit"
	Then I should see "Cannot uncheck read and write permissions. Delete user from project if this is what you intended."
	And I click "Cancel"
	Then I should be on the "First Project" page
	And "Sherry Wong" has "read" and "write" permission
	And I click "Manage user permissions"
	And I uncheck "read" permissions for "Sherry Wong"
	And I click "Submit"
	Then I should see "Cannot uncheck read permission when write permission is enabled."
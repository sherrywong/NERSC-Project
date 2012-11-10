Feature: Create a risk
    As a project member,
    So that I can capture risk associated with a particular project,
    I want to be able to document the specifics of the risk and add it to the risk log.
	
Background: some projects and no risks have been added to database
    Given I am logged in as an admin
    Given the following projects exist:
    | name           | description | 
    | First Project  | proj1       |  
    | Second Project | proj2       |  
    | Third Project  | proj3       |
    And I am on the project page 
	
Scenario: add and edit valid risk
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
#    When I fill in "risk_originator" with "Linda"
#    When I fill in "risk_owner" with "Linda"
    When I fill in "risk_description" with "Our second risk for project 1."
#    When I fill in "risk_date" with "02-12-2012"
    Then I press "Save"
    Then I should be on the Risk page for First Project
    And I should see "Risk 'Test Risk' created."
    When I go to the first project's Test Risk's Edit page
    When I fill in "risk_title" with "Title Changed"
    Then I press "Save"
    Then I should be on the first project's Risk page
    And I should see "Risk 'Title Changed' was successfully updated."

#Scenario: add risk with missing fields
#    When I go to First Project's Add Risk page
    # risk_owner
#    Then I fill in "risk_title" with "Test Risk2" 
#    Then I fill in "risk_description" with "Risk 4" 
#    Then I press "Save"
#    Then I should be on First Project's Add Risk page 
#    And I should see "Please fill out this field."

Scenario: View a risk that the user doesn't have read permission
    When I go to Second Project's Add Risk page
#    Then I should see "Error: Don't have permission to view the risks associated with this project."
    
Scenario: Add risk to a project when user doesn't have permission to add risk
    When I go to Third Project's Add Risk page
#    Then I should see "Error: Don't have permission to add risks to this project."

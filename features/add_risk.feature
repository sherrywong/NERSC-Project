Feature: Create a risk
    As a project member,
    So that I can capture risk associated with a particular project,
    I want to be able to document the specifics of the risk and add it to the risk log.

#Feature: Add Risk Fields
#    As a project member,
#    So I can have more comprehensive information about the projects risks,
#    I want to be able to add and edit a variety of information to risk.

#Feature: Add comment field (edit status/history of risk changes)
#    As an admin or project member,
#    So that I can make comments on the status or history of risk changes
#    I want to record changes made to the risk in a comment field.
	
Background: some projects and no risks have been added to database
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    And I am on the project page 
	
Scenario: add and edit valid risk
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I fill in "risk_owner" with "admin"
    When I fill in "risk_cost" with "1"
    When I fill in "risk_schedule" with "2"
    When I fill in "risk_technical" with "1"
    When I fill in "risk_probability" with "2"
    When I fill in "risk_status" with "active"
    When I fill in "risk_early_impact" with "1/2/13"
    When I fill in "risk_last_impact" with "3/2/13"
    When I fill in "risk_type" with "Cost/Technical"
    When I fill in "risk_description" with "Our second risk for project 1."
    Then I press "Save"
    Then I should be on the Risk page for First Project
    And I should see "Risk 'Test Risk' created."
    When I go to the first project's Test Risk's Edit page
    Then I should see "Title"
    Then I should see "Description"
    Then I should see "Cost"
    Then I should see "Probability"
    Then I should see "Risk Owner"
    Then I should see "Risk Creator"
    Then I should see "Risk Date"
    Then I should see "Comments"
    Then I should see "Short Title"
    Then I should see "Root Cause"
    Then I should see "Mitigation"
    Then I should see "Contingency"
    Then I should see "Cost"
    Then I should see "Schedule"
    Then I should see "Technical"
    Then I should see "Other Risks"
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
#    And I should see "Please fill out" 
#we will show all the fields the didn't fill out

Scenario: View a risk that the user doesn't have read permission
    When I go to Second Project's Add Risk page
#    Then I should see "Error: Don't have permission to view the risks associated with this project."
    
Scenario: Add risk to a project when user doesn't have permission to add risk
    When I go to Third Project's Add Risk page
#    Then I should see "Error: Don't have permission to add risks to this project."

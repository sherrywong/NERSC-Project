Feature: Create a risk
#    As a project member,
#    So that I can capture risk associated with a particular project,
#    I want to be able to document the specifics of the risk and add it to the risk log.

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
    Given a set of risks exist
    And I am on the project page 
	
Scenario: Add valid risk.
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    Then I should see "Short Title"
    When I fill in "risk_owner_id" with "admin"
    When I fill in "risk_description" with "Our test risk for First Project."
    Then I should see "Root Cause"
    When I select "High" from "risk[probability]"
    When I select "High" from "risk[cost]"
    When I select "Medium" from "risk[schedule]"
    When I select "Low" from "risk[technical]"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I should see "Mitigation"
    Then I should see "Contingency"
    Then I should see "Critical Path"
    Then I should see "WBS Spec"
    Then I should see "Type"
    Then I should see "Other Type"
    Then I should see "Comments"
    Then I press "Save"
    Then I should be on the Risk page for First Project
    Then there should be this message: "Risk 'Test Risk' created."

Scenario: Edit a valid risk.
    When I go to the Risk page for First Project
    When I go to the first project's First Risk's Edit page
    When I fill in "risk_title" with "Title Changed"
    Then I press "Save"
    Then I should be on the first project's Risk page
    And I should see "Risk 'Title Changed' was successfully updated."

Scenario: Add a risk with missing fields. #Doesn't have title.
    When I go to First Project's Add Risk page
    When I fill in "risk_owner_id" with "admin"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I select "High" from "risk[probability]"
    When I select "High" from "risk[cost]"
    When I select "Medium" from "risk[schedule]"
    When I select "Low" from "risk[technical]"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on First Project's Add Risk page
#we will show all the fields they didn't fill out

Scenario: View a risk that the user doesn't have read permission
    When I go to Second Project's Add Risk page
#    Then I should see "Error: Don't have permission to view the risks associated with this project."
    
Scenario: Add risk to a project when user doesn't have permission to add risk
    When I go to Third Project's Add Risk page
#    Then I should see "Error: Don't have permission to add risks to this project."

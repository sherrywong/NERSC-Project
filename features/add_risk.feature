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
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I select "admin" from "project[owner_id]"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I select "High" from "risk[probability]"
    When I select "High" from "risk[cost]"
    When I select "Medium" from "risk[schedule]"
    When I select "Low" from "risk[technical]"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I should see "Short Title"
    Then I should see "Root Cause"
    Then I should see "Mitigation"
    Then I should see "Contingency"
    Then I should see "Critical Path"
    Then I should see "WBS Spec"
    Then I should see "Type"
    Then I should see "Other Type"
    Then I should see "Comments"
    Then I press "Save"
    Then I should be on the risk index page for First Project
    Then there should be this message: "Risk 'Test Risk' created."
    When I follow "Test Risk"
    And I am on the Edit Risk page for Test Risk in the first project
    When I fill in "risk_description" with "D Changed"
    Then I press "Save"
    Then I should be on the Risk page for Test Risk in the first project
    Then there should be this message: "Risk 'Title Risk' was successfully updated."

Scenario: Project owners can add and edit a valid risk.
    Given I am logged in as Jason
    When I go to Second Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I select "lz" from "project[owner_id]"
    When I fill in "risk_description" with "P2 Test Risk"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for Second Project
    Then there should be this message: "Risk 'P2 Test Risk' created."
    When I go to the Edit Risk page for Test Risk in the second project
    When I fill in "risk_description" with "D Changed"
    Then I press "Save"
    Then I should be on the Risk page for Test Risk in the second project
    Then there should be this message: "Risk 'Title Risk' was successfully updated."

Scenario: Project members can add and edit a valid risk.
    Given I am logged in as Linda
    When I go to Second Project's Add Risk page
    When I fill in "risk_title" with "Test Risk2"
    When I select "jt" from "project[owner_id]"
    When I fill in "risk_description" with "P2 Test Risk2"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for Second Project
    Then there should be this message: "Risk 'P2 Test Risk2' created."
    When I go to the Edit Risk page for Test Risk2 in the second project
    When I fill in "risk_description" with "D Changed"
    Then I press "Save"
    Then I should be on the Risk page for Test Risk2 in the second project
    Then there should be this message: "Risk 'Title Risk2' was successfully updated."

Scenario: Add a risk with missing fields. #Doesn't have title.
    Given I am logged in as an admin
    When I go to First Project's Add Risk page
    When I select "admin" from "project[owner_id]"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on First Project's Add Risk page

Scenario: Non-project members cannot add and edit a valid risk.
    Given I am logged in as Sherry
    When I go to Second Project's Add Risk page
    Then I should see "Sorry, you don't have access to the requested project."

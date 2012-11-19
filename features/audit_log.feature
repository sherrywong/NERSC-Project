Feature: Maintain an audit log of changes to risks
    As a user,
    So that I can easily see and track changes made to risks,
    I want the audit logs to only show actual modifications made to risks

Background: Some projects have already been added to database.
    Given a set of users exist 
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist
    And I am on the project page
    
Scenario: Audit log modified when risk edited
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Audit Test Risk"
    When I fill in "risk_owner_id" with "admin"
    When I fill in "risk_description" with "Test Descrip"
    When I select "High" from "risk[probability]"
    When I select "High" from "risk[cost]"
    When I select "Medium" from "risk[schedule]"
    When I select "Low" from "risk[technical]"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for First Project
    Then there should be this message: "Risk 'Audit Test Risk' created."
    When I go to the Edit Risk page for Audit Test Risk in the first project
    When I fill in "risk_description" with "D Changed"
    Then I press "Save"
    When I go to the Risk page for Audit Test Risk in the first project
    Then there should a log on field "description", old value "Test Descrip", and new value "D Changed"
    #User who changed it, date?

Feature: Maintain an audit log of changes to risks
    As a user,
    So that I can easily see and track changes made to risks,
    I want the audit logs to only show actual modifications made to risks

Background: Some projects have already been added to database.
    Given a set of users exist 
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist

#User who changed it?
Scenario: Risk log generated on risk creation.
    Given I am logged in as an admin
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I select "admin" from "risk[owner_id]"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I select "High" from "risk[probability]"
    When I select "High" from "risk[cost]"
    When I select "Medium" from "risk[schedule]"
    When I select "Low" from "risk[technical]"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    When I go to the Risk page for Test Risk in the first project
    Then there should a log on field "title" with old value "nil" and new value "Test Risk"
    Then there should a log on field "description" with old value "nil" and new value "Our test risk for First Project."
    Then there should a log on field "status" with old value "nil" and new value "active"

Scenario: Audit log modified when risk edited
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Audit Test Risk"
    When I select "admin" from "risk[owner_id]"
    When I fill in "risk_description" with "Test Descrip"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2012-12-20"
    Then I press "Save"
    Then I should be on the risk index page for First Project
    Then there should be this message: "Risk 'Audit Test Risk' created."
    When I go to the Edit Risk page for Audit Test Risk in the first project
    When I fill in "risk_description" with "D Changed"
    Then I press "Save"
    When I go to the Risk page for Audit Test Risk in the first project
    Then there should a log on field "description" with old value "Test Descrip" and new value "D Changed"
    When I go to the Edit Risk page for Audit Test Risk in the first project
    When I fill in "risk_title" with "Tester"
    Then I press "Save"
    When I go to the Risk page for Tester in the first project
    Then there should a log on field "title" with old value "Audit Test Risk" and new value "Tester"
    When I go to the Edit Risk page for Tester in the first project
    When I fill in "risk_early_impact" with "2012-12-20"
    When I press "Save"
    When I go to the Risk page for Tester in the first project
    Then there should a log on field "early_impact" with old value "2008-11-20" and new value "2012-12-20"
    Then there should a log on field "days_to_impact" with old value "0" and new value "0"

Scenario: Risk log generated on risk deactivation
    Given I am logged in as an admin
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I select "admin" from "risk[owner_id]"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    When I go to the risk index page for First Project
    And I click on deactivate risk for "Test Risk" in "First Project"
    And I should see "Risk 'Test Risk' deactivated."
    When I go to the Risk page for Test Risk in the first project
    Then there should a log on field "status" with old value "active" and new value "retired"

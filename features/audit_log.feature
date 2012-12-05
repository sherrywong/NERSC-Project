Feature: Audit log (Maintain risk changes)
    As a user,
    So that I can easily see and track changes made to risks,
    I want the audit logs to only show actual modifications made to risks

Background: Some projects have already been added to database.
    Given a set of users exist 
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Risk log generated on risk creation.
    Given I am logged in as an admin
    Given that a risk exists with title "Test Risk", owner "admin", early impact "2013-11-20", and last impact "2014-10-20" for project "First Project"
    When I go to the Risk page for Test Risk in the first project
    Then there should a log on field "N/A" with old value "N/A" and new value "Risk Created"

Scenario: Audit log modified when risk edited
    Given that a risk exists with title "Audit Test Risk", owner "admin", early impact "2013-11-20", and last impact "2014-10-20" for project "First Project"
    When I go to the Edit Risk page for Audit Test Risk in the first project
    When I fill in "risk_title" with "Tester"
    Then I press "Save"
    When I go to the Risk page for Tester in the first project
    Then there should a log on field "title" with old value "Audit Test Risk" and new value "Tester"
    When I go to the Edit Risk page for Tester in the first project
    When I fill in "risk_early_impact" with "2015-12-20"
    When I press "Save"
    When I go to the Risk page for Tester in the first project
    Then there should a log on field "early_impact" with old value "2013-11-20" and new value "2015-12-20"
    Then there should a log on field "days_to_impact" with old value "0" and new value "0"

Scenario: Risk log generated on risk deactivation
    Given I am logged in as an admin
    Given that a risk exists with title "Test Risk", owner "admin", early impact "2013-11-20", and last impact "2014-10-20" for project "First Project"
    When I go to the risk index page for First Project
    And I click on deactivate risk for "Test Risk" in "First Project"
    And I should see "Risk 'Test Risk' deactivated."
    When I go to the Risk page for Test Risk in the first project
    Then there should a log on field "status" with old value "active" and new value "retired"

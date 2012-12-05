Feature: Risk Report (Track changes to a risk)
    As an admin or project member,
    So that I can have a measure of how effective the risk actions are
    I want to be able to track a specific risk before and after risk actions are taken
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given that a risk exists with title "Test Risk", owner "admin", early impact "2013-11-20", and last impact "2014-10-20" for project "First Project"
    When I go to the risk index page for First Project
    
Scenario: Expand risks to see full report for current risks
    When I select "Current Risks" from "report_select"
    And I follow "Preview"

Scenario: View near term risks
    When I select "Near Term Risks" from "report_select"
    And I follow "Preview"

Scenario: View mid term risks
    When I select "Mid Term Risks" from "report_select"
    And I follow "Preview"

Scenario: View far term risks
    When I select "Far Term Risks" from "report_select"
    And I follow "Preview"

Scenario: View far past risks
    When I select "Past Risks" from "report_select"
    And I follow "Preview"

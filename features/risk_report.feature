Feature: Risk Report (Track changes to a risk)
    As an admin or project member,
    So that I can have a measure of how effective the risk actions are
    I want to be able to track a specific risk before and after risk actions are taken
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    
Scenario: Expand risks to see full report
    Given I am logged in as an admin
    Given that a risk exists with title "Test Risk", owner "admin", early impact "2013-11-20", and last impact "2014-10-20" for project "First Project"
    Then I should be able to expand "Test Risk"
    When I select "Current Risks" from "report_select"
    And I follow "Preview"
    When I go to the risk index page for First Project
    When I select "Near Term Risks" from "report_select"
    And I follow "Preview"
    When I go to the risk index page for First Project
    When I select "Mid Term Risks" from "report_select"
    And I follow "Preview"
    When I go to the risk index page for First Project
    When I select "Far Term Risks" from "report_select"
    And I follow "Preview"
    When I go to the risk index page for First Project
    When I select "Past Risks" from "report_select"
    And I follow "Preview"

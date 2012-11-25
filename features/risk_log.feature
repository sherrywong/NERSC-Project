Feature: Risk log
As a user,
So that I can easily see and track changes made to risks,
I want the audit logs to only show what modifications have been made.

Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Risk log generated on risk creation.
    Given I am logged in as an admin
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I fill in "risk_owner_id" with "admin"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I select "High" from "risk[probability]"
    When I select "High" from "risk[cost]"
    When I select "Medium" from "risk[schedule]"
    When I select "Low" from "risk[technical]"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should see "title" with old value of "nil" and new value of "Test Risk"
    And I should see "description" with old value of "nil" and new value of "Our test risk for First Project."
    And I should see "status" with old value of "nil" and new value of "active"

Scenario: Risk log generated on risk change for explicit fields.
    Given I am logged in as Linda
    When I go to First Project's risk index page
    When I click on "Project 1 risk 1" 
    When I click on "Edit Risk" 
    When I fill in "risk_title" with "Tester"
    When I press "Save"
    Then I should see "title" with old value of "Project 1 risk 1" and new value of "Tester"

Scenario: Risk log generated on risk change for implicit (calculated) fields.
    Given I am logged in as Linda
    When I go to First Project's risk index page
    When I click on "Project 1 risk 1" 
    When I click on "Edit Risk" 
    When I fill in "risk_early_impact" with "2012-12-20"
    When I press "Save"
    Then I should see "early_impact" with old value of "2008-11-20" and new value of "2012-12-20"
    Then I should see "days_to_impact" with old value of "0"

Scenario: Risk log generated on risk deactivation
    Given I am logged in as admin
    When I go to First Project's risk index page
    When I click on "Deactivate" for "Project 1 risk 2" 
    Then I should see "Risk 'Project 1 risk 2' deactivated"
    And I should see "Project 1 risk 2" with "Status" of "retired"
    
    


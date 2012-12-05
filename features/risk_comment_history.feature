Feature: Risk comment history
    As a project member,
    So I can track notes associated to a project risk,
    I want to be able to see a date-sort comment log. 
	
Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
	
Scenario: Admins can add and edit a valid risk.
    Given I am logged in as an admin
    When I go to the project page for "First Project"
    Given that a risk exists with title "TestCRisk", owner "admin", early impact "2013-11-20", and last impact "2014-10-20" for project "First Project"
    When I go to the Edit Risk page for TestCRisk in the first project
    Then I fill in "risk_comment" with "Risk created."
    Then I press "Save"
    Then I should see comment "Risk created." by "admin"
    Then I should see comment "fdsfdsfdfds" by "admin"

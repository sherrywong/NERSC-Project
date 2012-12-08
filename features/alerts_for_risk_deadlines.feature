Feature: Alerts for risk deadlines
    As a project member and admin,
    So that I can review the risk and take the appropriate action
    I want to be notified when one of my risks hasn't been reviewed in a few weeks or moves into critical condition
	
Background: some projects and risks have already been added to database
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Admin gets risk alert for risk's early impact date
    Given I am logged in as an admin
    Given that a risk exists with title "Test Risk", owner "admin", early impact "2013-11-20", and last impact "2012-12-05" for project "First Project"
    Then there should be this message: "Risk 'Test Risk' created."
    Then an risk alert email will be sent for "Test Risk"

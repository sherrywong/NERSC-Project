Feature: Maintain an audit log of changes to risks
    As a user,
    So that I can easily see and track changes made to risks,
    I want the audit logs to only show actual modifications made to risks

Background: Some projects have already been added to database.
    Given a set of users exist 
    Given I am logged in as an admin
    Given a set of projects exist
    And I am on the project page
    Given a set of risks exist
    
Scenario: Audit log modified when risk edited
    Given I am logged in as an admin
    When I go to the Risk page for First Project
    When I go to the first project's Test Risk's Edit page
    When I fill in "risk_description" with "Description Changed"
    Then I press "Save"
    Then I should be on the first project's Risk page
    When I go to the audit log for "Test Risk"
    Then I should see "admin" for "User"
    Then I should see "2012/11/09 16:40" for "date"
    Then I should see "Risk Description" for "Entity"
    Then I should see "RDescrip" for "Old Entry"
    Then I should see "Description Changed" for "New Entry"

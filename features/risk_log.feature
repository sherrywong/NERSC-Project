Feature: Risk log
    As a user,
    So that I can easily see and track changes made to risks,
    I want the audit logs to only show what modifications have been made.

Background: Some projects and risks have been added to database.
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: We should see the time changed
    Given I am logged in as Jason
    When I go to the project page for "First Project"
    When I press "+ Display Associated Risks"
    When I follow "First Risk"

    When I fill in "risk_title" with "P3 Test Risk"
    When I select "lz" from "project[owner_id]"
    When I fill in "risk_description" with "P3 TR1"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for Second Project
    When I click on "p3 test risk"
    And I press "+ Edit Risk"
    And I fill in "risk_title" with "changed risk name"
    And I fill in "risk_early_impact" with "2010-11-30"
    And I fill in "risk_last_impact" with "2013-10-23"
    And I press "Save"
    Then "field modified" should include "title", "early_impact", "last_impact"
    And "old value" should include "P3 Test Risk", "2008-11-20", "2013-10-20"
    And "new value" should include "changed risk name", "2010-11-30", "2013-10-23"

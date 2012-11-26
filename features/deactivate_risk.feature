Feature: Deactivate a risk
    As a project owner,
    So that I can manage risks
    I want to be able to delete unnecesary or duplicate risks.

Background:
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist

Scenario: Admin can deactivate a risk. #Just member of project
    Given I am logged in as an admin
    When I go to Third Project's Add Risk page
    When I fill in "risk_title" with "P3 Test Risk"
    When I fill in "risk_owner_id" with "ag"
    When I fill in "risk_description" with "P3 TR1"
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for Third Project
    And I click on deactivate risk for "P3 Test Risk" in "Third Project"
#    Then I should see "Are you sure you want to delete test?"
#    Then I press "Yes"
    Then I should be on the risk index page for Third Project
    And I should see "Risk 'P3 Test Risk' deactivated."
    Then there should not be deactivate project for "P3 Test Risk"

Scenario: Risk owners can deactivate a risk.
    Given I am logged in as Linda
    When I go to Third Project's Add Risk page
    When I fill in "risk_title" with "P3 Test Risk3"
    When I fill in "risk_owner_id" with "ag"
    When I fill in "risk_description" with "P3 TR3."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    And I click on deactivate risk for "P3 Test Risk3" in "Third Project"
#    Then I should see "Are you sure you want to delete test?"
#    Then I press "Yes"
    Then I should be on the risk index page for Third Project
    And I should see "Risk 'P3 Test Risk3' deactivated."
    Then there should not be deactivate project for "P3 Test RIsk3"

Scenario: Project owners cannot deactivate a risk.
    Given I am logged in as Sherry
    When I go to Third Project's Add Risk page
    When I fill in "risk_title" with "P3 Test Risk2"
    When I fill in "risk_owner_id" with "ag"
    When I fill in "risk_description" with "P3 TR2."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for Third Project
    Then there should not be deactivate project for "P3 Test Risk2"

Scenario: A project member cannot deactivate a risk.
    Given I am logged in as Linda
    And I go to the risk index page for First Project
    Then there should not be deactivate project for "Second Risk"

Scenario: A project member cannot deactivate a risk.
    Given I am logged in as Linda
    When I go to Third Project's Add Risk page
    When I fill in "risk_title" with "P3 Test Risk4"
    When I fill in "risk_owner_id" with "ag"
    When I fill in "risk_description" with "P3 TR2."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for Third Project
    And I click on deactivate risk for "P3 Test Risk4" in "Third Project"
#    Then I should see "Are you sure you want to delete test?"
#    Then I press "Yes"
    Then I should be on the risk index page for Third Project
    Then I should see "You don't have permission to deactivate risk 'P3 Test Risk4'"

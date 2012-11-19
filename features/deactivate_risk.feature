Feature: Deactivate a risk
    As a project owner,
    So that I can manage risks
    I want to be able to delete unnecesary or duplicate risks.

Background:
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    Given a set of risks exist

Scenario: Admin or owners should be able to deactivate risk.
    Given I am logged in as an admin
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Deactivate Test Risk"
    When I fill in "risk_owner_id" with "admin"
    When I fill in "risk_description" with "Our test risk for First Project."
    When I fill in "risk_early_impact" with "2008-11-20"
    When I fill in "risk_last_impact" with "2013-10-20"
    Then I press "Save"
    Then I should be on the risk index page for First Project
    And I click on deactivate risk for "Deactivate Test Risk" in "First Project"
#    Then I should see "Are you sure you want to delete test?"
#    Then I press "Yes"
    Then I should be on the risk index page for First Project
    And I should see "Risk 'Deactivate Test Risk' deactivated."

Scenario: A user that is neither an owner nor an admin cannot deactivate a risk.
    Given I am logged in as Linda
    And I go to the risk index page for First Project
    Then there should not be deactivate project for "Second Risk"

Feature: Deactivate a risk
    As a project owner,
    So that I can manage risks
    I want to be able to delete unnecesary or duplicate risks.

Background:
    Given I am logged in as an admin
    Given a set of users exist
    Given a set of projects exist
    Given a set of risks exist

Scenario: Admin or owners should be able to deactivate risk.
    Given I am logged in as an admin
    And I go to the Risk page for First Project
    And I click on deactivate risk for "First Risk" in "First Project"
#    Then I should see "Are you sure you want to delete test?"
#    Then I press "Yes"
    Then I should be on the Risk page for First Project
    And I should see "Risk 'First Risk' deactivated."

Scenario: A user that is neither an owner nor an admin cannot deactivate a risk.
    Given I am logged in as Linda
    And I go to the Risk page for First Project
    Then there should not be deactivate project for "Second Risk"

Feature: Deactivate a risk
    As a project owner,
    So that I can manage risks
    I want to be able to delete unnecesary or duplicate risks.

Background:
    Given a set of users exist
    Given a set of projects exist
    And the following risks exist:
    |cost | description | probability | title | user_id | proj_id |
    |10   | testing     | high        | test  | 1       | 1       |

Scenario: non-owner/admins cannot delete risk
    Given I am logged in as a non-owner user
    And I go to the Risk page for First Project
    And I click on delete risk for "test"
    Then I should see "You do have permission to delete this risk." 

Scenario: admin or owners should be able to delete risk
    Given I am logged in as an admin
    And I go to the Risk page for First Project
    And I click on delete risk for "test" 
    Then I should see "Are you sure you want to delete test?"
    And I click "Yes"
    And I go to the Risk page for First Project
    And I should not see "test"

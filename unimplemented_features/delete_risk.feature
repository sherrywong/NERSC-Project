Feature: Delete a risk
	As a project owner,
	So that I can manage risks
	I want to be able to delete unnecesary or duplicate risks.

Background:   
    Given the following projects exist: 
    | name           | description |
    | First Project  | proj1       |
    | Second Project | proj2       |
    | Third Project  | proj3       |

    And the following risks exist: 

    |cost | description | probability | title | user_id | proj_id |
    |10   | testing     | high        | test  | 1       | 1       |

Scenario: non-owner/admins cannot delete risk
    Given I am logged in as a non-owner user
    And I go project 1's page
    And I click on "test"
    And I click "Delete Risk" 
    Then I should see "You do have permission to delete this risk." 

Scenario: admin or owners should be able to delete risk
    Given I am logged in as an admin
    And I go project 1's page
    And I click on "test"
    And I click "Delete Risk" 
    Then I should see "Are you sure you want to delete test?"
    And I click "Yes"
    Then I should be on project 1's page
    And I should not see "test"
     

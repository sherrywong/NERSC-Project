Feature: Create a risk
	As a project member,
	So that I can capture risk associated with a particular project,
	I want to be able to document the specifics of the risk and add it to the risk log.

Background: no risks have been added to database      
    Given the following projects exist: 
    | name           | description | 
    | First Project  | proj1       |  
    | Second Project | proj2       |  
    | Third Project  | proj3       |  
 
    And I am on the project page 
     
Scenario: add valid risk
    Given I go to Project named "proj1"
    And I go to the manage risk page
    And I click "Add Risk"
    Then I should be on the new risk page 
    Then I fill in "risk_name" with "Test Risk" 
    Then I fill in "risk_description" with "Risk 4" 
    Then I press "Create Risk" 
    Then I should be on the risk index page for "proj1"
    And I should see "Test Risk"

Scenario: add risk with missing fields 
    Given I go to Project named "proj1"
    And I go to the manage risk page
    And I click "Add Risk"
    Then I should be on the new risk page 
    Then I fill in "risk_name" with "Test Risk" 
    Then I fill in "risk_description" with "Risk 4" 
    Then I press "Create Risk" 
    Then I should be on the create risk page 
    And I should see "Error: Missing fields"
    
Scenario: view a project that the user doesn't have read spermission
    Given I go to Project named "proj2"
    And I go to the manage risk page 
    Then I should see "Don't have permission to view the risks associated with this project."
    
Scenario: add risk to a project that user doesn't have permission to add risk
    Given I go to Project named "proj3"
    And I go to the manage risk page
    And I click "Add Risk"
    Then I should see "Don't have permission to add risks to this project."

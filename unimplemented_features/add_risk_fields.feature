Feature: Add Risk Fields
    As a project member,
    So I can have more comprehensive information about the project risks,
    I want to be able to add and edit a variety of information to risk.
     
Background: Some projects have already been added to database.
    Given I am logged in as an admin
    Given the following projects exist: 
    | name           | description | 
    | First Project  | proj1       |

Scenario: Risk fields should be present when creating a risk
    When I go to First Project's Add Risk page
    Then I should see "Title"
    Then I should see "Description"
    Then I should see "Cost"
    Then I should see "Probability"
    Then I should see "Risk Owner"
    Then I should see "Risk Creator"
    Then I should see "Risk Date"
    Then I should see "Comments"

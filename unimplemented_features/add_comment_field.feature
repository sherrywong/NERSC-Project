Feature: Add comment field (edit status/history of risk changes)
    As an admin or project member,
    So that I can make comments on the status or history of risk changes
    I want to record changes made to the risk in a comment field.

Background: some projects and no risks have been added to database
    Given I am logged in as an admin
    Given the following projects exist:
    | name           | description | 
    | First Project  | proj1       |
    And I am on the project page

Scenario: add and edit valid risk
    When I go to First Project's Add Risk page
    When I fill in "risk_title" with "Test Risk"
    When I fill in "risk_description" with "Our second risk for project 1."
    When I fill in "risk_comment" with "Risk comment."
    Then I press "Save"
    Then I should be on the Risk page for First Project
    And I should see "Risk 'Test Risk' created."

Feature: Risk Matrix
# As a project owner,
# So that I can set parameters and categories for that project's risks,
# I should be ale to set project specific risk parameters.

Background: some projects and no risks have been added to database
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist
    And I am on the project page 

Scenario: set project specific risk parameters
    When I go to the new project page
    When I fill in "project_name" with "Test Project" 
    And I fill in "project_prefix" with "test"
    And I fill in "project_description" with "Project 4"
    And I fill in "project_owner_username_members" with "admin"
    When I select "Low" from "project[probability_impact_11]"
    Then "project[probability_impact_11]" should be "Low"
    And "project[probability_impact_11]" should be "green"
    When I select "High" from "project[probability_impact_21]"
    Then "project[probability_impact_21]" should be "High"
    And "project[probability_impact_21]" should be "red"
    When I select "Medium" from "project[probability_impact_12]"
    Then "project[probability_impact_12]" should be "Med"
    And "project[probability_impact_12]" should be "yellow"
    Then I press "Save" 
    Then I should be on the project page
    And I should see "Project 'Test Project' created."
    And I should see "Test Project"
    Then I sort projects by "title"
    Then I sort projects by "status"

    

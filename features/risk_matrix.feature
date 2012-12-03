Feature: Risk Matrix
# As a project owner,
# So that I can set parameters and categories for that project's risks,
# I should be ale to set project specific risk parameters.

Background: some projects and no risks have been added to database
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: set project specific risk parameters
    When I go to the new project page
    When I fill in "project_name" with "Test Project" 
    And I fill in "project_prefix" with "test"
    And I fill in "project_description" with "Project 4"
    When I select "admin" from "project[owner_id]"
    When I select "Low" from "project[probability_impact_11]"
    When I select "High" from "project[probability_impact_21]"
    When I select "Med" from "project[probability_impact_12]"
    Then I press "Save" 
    Then I should be on the project page for "Test Project"
    And I should see "Project 'Test Project' created."
    And I should see "Test Project"

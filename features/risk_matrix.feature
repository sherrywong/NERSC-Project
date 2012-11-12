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
    When I fill in "risk_matrix[0][0]" with "Low"
    Then "risk_matrix[0][0]" should be "Low"
    And "risk_matrix[0][0]" should be "green"
    When I fill in "risk_matrix[2][1]" with "High"
    Then "risk_matrix[2][1]" should be "High"
    And "risk_matrix[2][1]" should be "red"
    When I fill in "risk_matrix[1][2]" with "Med"
    Then "risk_matrix[1][2]" should be "Med"
    And "risk_matrix[1][2]" should be "yellow"
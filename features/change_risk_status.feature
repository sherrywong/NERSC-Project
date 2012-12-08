Feature: Change risk status
    As a project owner,
    So that I can manage risks in the system
    I want to be able to deactivate/reactivate projects

Background:
    Given a set of users exist
    Given I am logged in as an admin
    Given a set of projects exist

Scenario: Admin can deactivate and reactivate a risk. #Just member of project
    Given I am logged in as an admin
    Given that a risk exists with title "P3 Test Risk", owner "ag", early impact "2013-11-20", and last impact "2014-10-20" for project "First Project"
    And I click on deactivate risk for "P3 Test Risk" in "Third Project"
    And I should see "Risk 'P3 Test Risk' deactivated."
    Then there should not be deactivate "project" for "P3 Test Risk"
    And I click on reactivate risk for "P3 Test Risk" in "Third Project"
    Then I should be on the risk index page for Third Project
    And I should see "Risk 'P3 Test Risk' reactivated."
    Then there should not be reactivate "project" for "P3 Test Risk"

Scenario: Risk owners can deactivate a risk.
    Given I am logged in as Linda
    Given that a risk exists with title "P3 Test Risk3", owner "lz", early impact "2013-11-20", and last impact "2014-10-20" for project "Third Project"
    And I click on deactivate risk for "P3 Test Risk3" in "Third Project"
    Then I should be on the risk index page for Third Project
    And I should see "Risk 'P3 Test Risk3' deactivated."
    Then there should not be deactivate "project" for "P3 Test Risk3"
    And I click on reactivate risk for "P3 Test Risk3" in "Third Project"
    Then I should be on the risk index page for Third Project
    And I should see "Risk 'P3 Test Risk3' reactivated."
    Then there should not be reactivate "project" for "P3 Test Risk3"

Scenario: Project owners cannot deactivate a risk.
    Given I am logged in as Sherry
    Given that a risk exists with title "P3 Test Risk2", owner "ag", early impact "2013-11-20", and last impact "2014-10-20" for project "Third Project"
    Then there should not be deactivate "project" for "P3 Test Risk2"
    Then there should not be reactivate "project" for "P3 Test Risk2"

Scenario: A project member cannot deactivate a risk.
    Given I am logged in as Linda
    And I go to the risk index page for First Project
    Then there should not be deactivate "project" for "Second Risk"
    Then there should not be reactivate "project" for "Second Risk"

Scenario: A project member cannot deactivate a risk.
    Given I am logged in as Linda
    Given that a risk exists with title "P3 Test Risk4", owner "ag", early impact "2013-11-20", and last impact "2014-10-20" for project "Third Project"
    And I click on deactivate risk for "P3 Test Risk4" in "Third Project"
    Then I should be on the risk index page for Third Project
    Then I should see "Sorry, you have to be an admin or project owner or risk owner to perform this action."
    And I click on reactivate risk for "P3 Test Risk4" in "Third Project"
    Then I should be on the risk index page for Third Project
    Then I should see "Sorry, you have to be an admin or project owner or risk owner to perform this action."

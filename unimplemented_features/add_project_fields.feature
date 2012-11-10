Feature: Add Project Fields
    As a project owner,
    So I can have more comprehensive information about my projects,
    I want to be able to add and edit a variety of information to each project.
     
Background: Some projects have already been added to database.
    Given the following users exist:
    | username  | email             | first       | last         | admin | password        |
    | admin     | admin@gmail.com   | admin       | admin        | true  | admin           |
    Given I am logged in as an admin
    Given the following projects exist: 
    | name           | description | 
    | First Project  | proj1       |

Scenario: Project fields should be present when creating a project.
    And I am on the project page
    When I go to the new project page
    Then I should see "Name"
    Then I should see "Description"
    Then I should see "Project Owner"
    Then I should see "Prefix"
    Then I should see "Matrix"

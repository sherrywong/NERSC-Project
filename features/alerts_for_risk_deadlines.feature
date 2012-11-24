Feature: Alerts for risk deadlines
  As a project member and admin,
  So that I can review the risk and take the appropriate action
  I want to be notified when one of my risks hasn't been reviewed in a few weeks or moves into critical condition
	
Background: some projects and risks have already been added to database
  Given a set of users exist
  Given that I am logged in as an admin
  Given a set of projects exist
  Given a set of risks exist
  And the following risks exist:
#  | title       | project        | risk_id | originator | owner  | description                   | id_date    | last-reviewed | deadline   | review-frequency | condition |
#  | First Risk  | First Project  | 1-1     | Linda      | Anna   | Our first risk for project 1. | 02-11-2012 | 02-11-2012    | 01-11-2014 | 14               | stable    |
#  | Second Risk | Second Project | 2-1     | Jason      | Elise  | Our first risk for project 2. | 03-11-2012 | 03-11-2012    | 01-11-2014 | 14               | stable    |
#  | Third Risk  | Third Project  | 3-1     | Anna       | Sherry | Our first risk for project 3. | 04-11-2012 | 04-11-2012    | 04-15-2012 | 14               | stable    |
	
  And I am on the risk page for "First Project"
    
#This story needs to be refined a bit more - how do users want to be notified? e-mail? notice message on login?
# For the sake of initial scenarios I write with a vaguely defined step, to be refined later.

Scenario: No warning if the project is ok.
  Given that I am logged in as Linda
  And I am on the project page for "First Project"
  And the date is "02-15-2012"
  And I should not be notified that "First Risk" needs to be reviewed.
    
Scenario: Warning if it's been longer than the the review-frequency requirement.
  Given that I am logged in as Linda
  And I am on the project page for "First Project"
  And the date is "03-11-2012"
  And I should be notified that "First Risk" needs to be reviewed.
    
Scenario: Warning if it's past the deadline
  Given that I am logged in as Sherry
  And I am on the project page for "Third Project"
  And the date is "04-18-2012"
  And I should be notified that "Third Risk" needs to be reviewed.
    
Scenario: Warning if a risk moves into critical condition
  Given that I am logged in as Jason
  And I am on the project page for "Second Project"
  And the date is "03-12-2012"
  When I set the condition of "Second Risk" to "critical"
  And I should be notified that "Second Risk" needs to be reviewed.
  

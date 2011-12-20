Feature: Leave a comment
	In order to improve communication between client and developers
	As a project member
	I want to be able to comment on features, scenarios and steps
	
	@javascript
	Scenario: Comment on a scenario
		Given I am logged in as "admin" with password "admin"
		Given I am on the feature "Fixture Feature" page
		When I leave a comment saying "I think this feature should be removed altogether."
		Then the feature should have 1 comment
		When I delete the comment
		Then the feature should have 0 comments
		

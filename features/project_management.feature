Feature: Project Management

	Scenario: Creating Project
		Given I am logged in as "admin" with password "admin"
		And I am on the projects page
		When I follow "New Project"
		And I fill in the following:
			| Name	| Dummy Project								|
			| Repo	| http://github.com/dcastro/mads.2011.git	|
		And I press "Create Project"
		And I go to the projects page
		Then I should have a project named "Dummy Project" with 1 member
		And I should see "Dummy Project"
		
	@javascript
	Scenario: Adding members
		Given I am logged in as "admin" with password "admin"
		And I am on the projects page
		When I follow "Fixture Project"
		And I fill in "username" with "Dio"
		And I wait for 2 seconds
		Then I should see "Diogo"
		When I AJAX click on "Diogo"
		And I select "Developer" from "usertype"
		And I press "Add"
		Then user "Diogo" should be a "Developer" on project "Fixture Project"
		
	Scenario: Removing members
		Given I am logged in as "admin" with password "admin"
		And I am on the projects page
		When I follow "Fixture Project 2"
		Then I should see "Diogo"
		When I press "remove_dcastro"
		Then "dcastro" should not be a member of "Fixture Project 2"


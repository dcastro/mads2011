Feature: Project Managment

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
		

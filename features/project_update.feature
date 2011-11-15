Feature: Project Update
	In order to keep my client up-to-date
	As a Developer
	I want to be able to update my project status
	
	Scenario: Update Features
		Given I am logged in as "admin" with password "admin"
		And I am on the projects page
		When I follow "Fixture Project 2"
		And I press "Update State"	
		Then "Lol" should be a feature of "Fixture Project 2"
		And feature "Lol" should have the following scenarios:
			| Name					|
			| Brand New Test		|
			| O produto e listado	|
			| Adicionar produto		|
			| Adicionar produto v2	|
		And scenario "Brand New Test" should have the following steps:
			| Keyword	| Name 								|
			| Given		| I am on the homepage				|
			| When		| I press "say goodbye"				|
			| Then		| I should be on the goodbye page	|
			
		
		
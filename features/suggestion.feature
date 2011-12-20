Feature: Suggest a new scenario
	In order to get involved with the project
	As a project member
	I want to be able to suggest a new scenario for a given feature

	@javascript
	Scenario: Suggest a new Scenario
		Given I am logged in as "admin" with password "admin"
		And the following suggestion data:
			| Name			| New Suggestion				|
			| Description	| This is a dummy suggestion	|
		And the following suggestion steps:
			| keyword	| name									| rows & cells															|
			| Given		| I am on the homepage					|																		|
			| When		| I add the following product:			| name, Iran Costa Debut Album & price, 19.99 & description, brand new	|
			| Then		| I should see it in the products page	|																		|
		And I am on the feature "Fixture Feature" page
		When I open and fill in the suggestions form
		And I press "Create Suggestion"
		Then I should see the new suggestion

	@javascript
	Scenario: Delete a suggestion
		Given I am logged in as "admin" with password "admin"
		And the following suggestion belongs to the feature "Fixture Feature":
			| name			| New Suggestion				|
			| description	| This is a dummy suggestion	|
		And I am on the feature "Fixture Feature" page
		When I delete this suggestion
		Then I should no longer see this suggestion
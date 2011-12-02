Feature: Suggest a new scenario
	In order to get involved with the project
	As an authenticated user
	I want to be able to suggest a new scenario for a given feature

	@javascript
	Scenario:
		Given I am logged in as "admin" with password "admin"
		And the following suggestion data:
			| name			| New Suggestion				|
			| description	| This is a dummy suggestion	|
		And the following suggestion steps:
			| keyword	| name									| rows & cells	|
			| Given		| I am on the homepage					|				|
			| When		| I add the following product:			| name, Iran Costa Debut Album & price, 19.99 & description, brand new |
			| Then		| I should see it in the products page	|				|
		And I am on the projects page
		When I follow "Fixture Project 2"
		And I follow "Fixture Feature"
		Then lol

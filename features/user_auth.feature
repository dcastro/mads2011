Feature: User Authentication

	Scenario: Login
		Given I am on the homepage
		When I fill in "username" with "admin"
		And I fill in "password" with "admin"
		And I press "Login"
		Then I should see "Logged in as Administrador"

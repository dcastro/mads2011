Feature: User Authentication

	Scenario: Login
		Given I am on the homepage
		When I fill in "username" with "admin"
		And I fill in "password" with "admin"
		And I press "Login"
		Then I should see "Logged in as Administrador"

	Scenario: Logout
		Given I am logged in as "admin" with password "admin"
		And I am on the homepage
		When I press "Logout"
		Then I should be on the homepage
		And I should be logged out
		
	Scenario: View Profile
		Given I am logged in as "admin" with password "admin"
		And I am on the homepage
		When I follow "Administrador"
		Then I should be on the admin's profile page

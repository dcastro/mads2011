Feature: User Authentication

	Scenario Outline: Login
		Given the following user records:
			| username		| password	| name			|
			| admin_user	| 1234		| Administrador	|
			| test_user		| 1234		| User X		|
		When I login with username "<username>" and password "<password>"
		Then I should <action>
		
		Scenarios:
			| username		| password			| action							|
			| admin_user	| 1234				| see "Logged in as Administrador"	|
			| test_user		| wrong_password	| see "Logged in as"			|
		

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
		And I should see admin's email, contact and name

	Scenario: Registration
		Given I am on the homepage
		When I press "Register"
		And I fill in the following:
			| Name		| Diogo Castro		|
			| Username	| user_dcastro		|
			| Password	| 1234				|
			| Confirm	| 1234				|
			| E-mail	| ei07171@fe.up.pt	|
			| Contact	| 91 442 4559		|
		And I press "Create Account"
		And I go to the user_dcastro's profile page
		Then I should see "Logged in as Diogo Castro"
		And I should see user_dcastro's email, contact and name
		
		
				

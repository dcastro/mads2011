Given /^(?:|I )am logged in as "([^"]*)"$/ do |link|
	visit(path_to("the homepage"))
	fill_in "username", with: "admin"
	fill_in "password", with: "admin"
	click_button "Login"
	
end

Then /^(?:|I )should be logged out/ do
	assert page.body.include?("action=\"/users/login\"")
end

Given /^(?:|I )am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
	visit(path_to("the homepage"))
	fill_in "username", with: username
	fill_in "password", with: password
	click_button "Login"
	
end

Then /^(?:|I )should be logged out/ do
	assert page.body.include?("action=\"/users/login\"")
end

Given /^(?:|I )am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
	visit(path_to("the homepage"))
	fill_in "username", with: username
	fill_in "password", with: password
	click_button "Login"
	
	@user = User.find_by_username(username)
	
end

Then /^(?:|I )should be logged out/ do
	assert page.body.include?("action=\"/users/login\"")
end


Then /^(?:|I )should see ([^"]*)'s ([^"]*)/ do |username, fields|
  user = User.find_by_username(username)
  fields_arr = fields.split(/, | and /)
  
  fields_arr.each do |f|
    field_content = user.send(f)
     
    if page.respond_to? :should
      page.should have_content(field_content)
    else
      assert page.has_content?(field_content)
    end
  end

end
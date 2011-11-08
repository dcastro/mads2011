Then /^(?:|I )should have a project named "([^"]*)" with (\d*) members?/ do |project_name, n_members|
  assert @proj = @user.projects.find_by_name(project_name)
  assert_equal @proj.users.count, n_members.to_i
end

When /^(?:|I )wait for (\d*) seconds/ do |seconds|
  sleep seconds.to_i
end


When /^I AJAX click on "([^"]*)"/ do |link_text|
  # page.evaluate_script %Q{ $('.ui-menu-item a:contains("#{link_text}")').trigger("mouseenter").click(); }
  page.driver.browser.execute_script %Q{ $('.ui-menu-item a:contains("#{link_text}")').trigger("mouseenter").click(); }
end

Then /^user "([^"]*)" should be a "([^"]*)" on project "([^"]*)"$/ do |user, role, project|
  assert Role.where(
          name: role,
          user: User.find_by_name(user),
          project: @user.projects.find_by_name(project)
  )
end

Then /^"([^"]*)" should not be a member of "([^"]*)"$/ do |username, project|
  assert Role.where(
          user_id: User.find_by_username(username).id,
          project_id: Project.find_by_name(project).id
  ).empty?
end

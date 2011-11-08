Then /^(?:|I )should have a project named "([^"]*)" with (\d*) members?/ do |project_name, n_members|
  assert @proj = @user.projects.find_by_name(project_name)
  assert_equal @proj.users.count, n_members.to_i
end
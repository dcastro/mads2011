When /^I leave a comment saying "([^"]*)"$/ do |content|

  step %{I fill in "content" with "#{ content }"}
  step %{I press "Save"}
  sleep 1
  
end


When /^I leave a comment on scenario "([^"]*)" saying "([^"]*)"$/ do |scenario_name, content|
  
  #display scenario comments
  @scenario = @feature.scenarios.find_by_name(scenario_name)
  sleep 1
  page.driver.browser.execute_script %Q{ $('#Scenario#{ @scenario.id }').trigger("mouseenter").click(); }
  sleep 1
  
  #leave comment
  step %{I leave a comment saying "#{ content }"}
  
end

When /^I leave a comment on scenario "([^"]*)"'s first step saying "([^"]*)"$/ do |scenario_name, content|
  @step = @feature.scenarios.find_by_name(scenario_name).steps.first
  
  #open scenario tab
  sleep 1
  page.driver.browser.execute_script %Q{ $('h5:contains("#{scenario_name}")').trigger("mouseenter").click(); }
  
  #display step comments
  sleep 1
  step %{I follow "#{ @step.name }"}
  sleep 1
  
  #leave comment
  step %{I leave a comment saying "#{ content }"}  
  
end



Then /^the feature should have (\d+) comments?$/ do |n_comments|
  assert_equal n_comments.to_i, @feature.comments.count
end

Then /^the scenario should have (\d+) comments?$/ do |n_comments|
  assert_equal n_comments.to_i, @scenario.comments.count
end

Then /^the step should have (\d+) comments?$/ do |n_comments|
  assert_equal n_comments.to_i, @step.comments.count
end

When /^I delete the comment$/ do
  step %{I follow "delete_comment"}
  sleep 1
end
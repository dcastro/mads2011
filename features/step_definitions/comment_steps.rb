When /^I leave a comment saying "([^"]*)"$/ do |content|

  step %{I fill in "content" with "#{ content }"}
  step %{I press "Save"}
  sleep 1
  
end


Then /^the feature should have (\d+) comments?$/ do |n_comments|
  assert_equal n_comments.to_i, @feature.comments.count
  
end

When /^I delete the comment$/ do
  step %{I follow "delete_comment"}
  sleep 1
end
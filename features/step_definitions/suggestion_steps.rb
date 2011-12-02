Given /^the following suggestion data:$/ do |table|
  p table
end

Given /^the following suggestion steps:$/ do |table|
  p table
end

Then /^lol$/ do
  sleep 8
end

When /^I AJAX click2 on "([^"]*)"/ do |link_text|
  # page.evaluate_script %Q{ $('.ui-menu-item a:contains("#{link_text}")').trigger("mouseenter").click(); }
  page.driver.browser.execute_script %Q{ $('div:contains("#{link_text}")').trigger("mouseenter").click(); }
end
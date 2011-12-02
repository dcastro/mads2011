And /^I press (.*) to "(.*)"$/ do |key, element|
  find(element).press_key(key)
end
Given /^I am at the (.+) page$/ do |page|
  visit path_to(page)
end

Then /^I should see a link with "(.*?)"$/ do |content|
  expect(page).to have_selector('a', text: content)
end

Then /^I should see "(.*?)"$/ do |content|
  expect(page).to have_content(content)
end

When /^I go to the (.+) page$/ do |page|
  visit path_to(page)
end

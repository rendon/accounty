When /^I go to the company Operations$/ do
  click_link 'Operations'
  click_link 'Add operation'
end

When /^I add an operation$/ do
  fill_in 'Description', with: 'Buy some beer'
  click_button 'Next'
end

Then /^I should be at the operation page$/ do
  expect(page).to have_content('Buy some beer')
  expect(page).to have_selector('a', 'Add detail')
end

Given /^I have registered my accounts$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have created an operation$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I add an operation details$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the new detail in the list$/ do
  pending # express the regexp above with the code you wish you had
end

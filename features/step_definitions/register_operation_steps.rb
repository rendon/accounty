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


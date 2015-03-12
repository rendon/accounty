Then /^I should see the "(.*?)" link$/ do |link_name|
  expect(page).to have_selector('a', text: link_name)
end

When /^I go to the company Accounts$/ do
  click_link 'Accounts'
end

When /^I add and account$/ do
  click_link 'Add account'
  fill_in 'Name', with: 'Cash'
  fill_in 'Description', with: 'Money for immediate use ...'
  select 'Assets', from: 'Category'
  select 'Current', from: 'Subcategory'
  click_button 'Save'
end

Then /^I should see that account listed$/ do
  expect(page).to have_content('Cash')
end

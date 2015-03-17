When /^I sign up with valid data$/ do
  fill_in 'Name', with: 'Rafael'
  fill_in 'Last name', with: 'Rendon Pablo'
  fill_in 'Email', with: 'rafaelrendonpablo@gmail.com'
  fill_in 'Password', with: '0a1b2c3d4e'
  fill_in 'Password confirmation', with: '0a1b2c3d4e'
  click_button 'Create my account'
end

Then /^I should be logged in$/ do
  expect(page).to have_selector('a', text: 'Log out')
end

When /^I sign up with an invalid email$/ do
  fill_in 'Name', with: 'Rafael'
  fill_in 'Last name', with: 'Rendon Pablo'
  fill_in 'Email', with: 'rafaelrendonpabloATgmail.com'
  fill_in 'Password', with: '0a1b2c3d4e'
  fill_in 'Password confirmation', with: '0a1b2c3d4e'
  click_button 'Create my account'
end

Then /^I should not be signed in$/ do
  expect(page).to have_css('div.alert-danger')
  expect(page).to have_selector('form')
end

When /^I sign up without a name$/ do
  fill_in 'Name', with: ''
  fill_in 'Last name', with: 'Rendon Pablo'
  fill_in 'Email', with: 'rafaelrendonpablo@gmail.com'
  fill_in 'Password', with: '0a1b2c3d4e'
  fill_in 'Password confirmation', with: '0a1b2c3d4e'
  click_button 'Create my account'
end

When /^I sign up with a weak password$/ do
  fill_in 'Name', with: 'Rafael'
  fill_in 'Last name', with: 'Rendon Pablo'
  fill_in 'Email', with: 'rafaelrendonpablo@gmail.com'
  fill_in 'Password', with: '0a1b2c3'
  fill_in 'Password confirmation', with: '0a1b2c3'
  click_button 'Create my account'
end

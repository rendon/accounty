Given /^I have an account$/ do
  @user = create(:user)
end

When /^I log in with valid data$/ do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

When /^I log in with non\-registered email$/ do
  fill_in 'Email', with: 'non_registeredemail@example.com'
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

When /^I log in with the wrong password$/ do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password + 'x'
  click_button 'Log in'
end

Then /^I should not be logged in$/ do
  expect(page).to have_content('Email and password combination do not match.')
end

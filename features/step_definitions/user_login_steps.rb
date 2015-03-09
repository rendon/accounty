Given /^I have an account$/ do
  @user = create :user
end

When /^I login with valid data$/ do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

When /^I login with non\-registered email$/ do
  fill_in 'Email', with: 'non_registeredemail@example.com'
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

When /^I login with the wrong password$/ do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password + 'x'
  click_button 'Log in'
end

Then /^I should be logged in$/ do
  expect(page).to have_content("Welcome back #{@user.name}!")
end

Then /^I should not be logged in$/ do
  expect(page).to have_content('Email and password combination do not match.')
end

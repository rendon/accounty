Given /^I am logged in$/ do
  @user = create(:user)
  visit path_to('log in')
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

When /^I log out$/ do
  click_link 'Log out'
end

Then /^I should be logged out$/ do
  expect(find_link('Log in')[:href]).to be == login_path
end

When /^I go to my settings page$/ do
  click_link 'Settings'
end

Then /^I should see my user information$/ do
  expect(page).to have_content("#{@user.name} #{@user.last_name}")
  expect(page).to have_content("#{@user.email}")
  expect(page).to have_selector('img')
end

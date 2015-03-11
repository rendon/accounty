Then /^I should see my dashboard$/ do
  expect(page).to have_content 'My companies'
end

Given /^I do not have companies$/ do
end

When /^I go to the dashboard$/ do
  visit user_companies_path(@user)
end

When /^I create a company$/ do
  click_link 'Add company'
  fill_in 'Name', with: 'Inforscience'
  fill_in 'Description', with: 'My imaginary company.'
  click_button 'Create'
end

Then /^I should have a company$/ do
  expect(page).to have_content('Inforscience')
end

Given /^I have a company$/ do
  @user.companies.create(attributes_for(:company))
end

Then /^I should have two companies$/ do
  expect(page).to have_content(@user.companies[0].name)
  expect(page).to have_content(@user.companies[1].name)
end

Given /^I have companies$/ do
  @user.companies.create(attributes_for(:company))
  @user.companies.create(attributes_for(:company))
  @user.companies.create(attributes_for(:company))
end

Then /^I should see my companies$/ do
  @user.companies.each do |company|
    expect(page).to have_content(company.name)
  end
end

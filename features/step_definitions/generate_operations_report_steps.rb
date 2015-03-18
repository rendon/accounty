Given /^I have done operations by three months$/ do
  #@cash  = @company.accounts.create(attributes_for(:account, name: 'Cash',
  #                                                 category: :assets))
  #@wages = @company.accounts.create(attributes_for(:account,
  #                                                 name: 'Wages payable',
  #                                                 category: :liabilities))
  @first_operation = @company.operations.create(description: 'Pay my employees',
                                                created_at: Date.new(2015, 1, 1))
  @second_operation = @company.operations.create(description: 'Receive some money',
                                                 created_at: Date.new(2015, 2, 1))
  @third_operation = @company.operations.create(description: 'Buy merchandise',
                                                created_at: Date.new(2015, 3, 1))
end

When /^I go to Operations$/ do
  visit user_company_path(@user, @company)
  click_link 'Reports'
end

When /^I generate a report$/ do
  click_button 'Generate'
end

Then /^I should see only the operations of the last month$/ do
  expect(page).to have_selector('td', text: 'Buy merchandise')
  expect(page).to have_selector('tr', count: 1)
end

When /^I generate a report of the previous month$/ do
  fill_in 'Start date', with: '2015/2/1'
  fill_in 'End date', with: '2015/2/28'
  click_button 'Generate'
end

Then /^I should see only the operations of the previous month$/ do
  expect(page).to have_selector('td', text: 'Receive some money')
  expect(page).to have_selector('tr', count: 1)
end

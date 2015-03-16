Given /^I have registered my accounts$/ do
  @company.accounts.create(attributes_for(:account, name: 'Cash'))
  @company.accounts.create(attributes_for(:account, name: 'Inventory'))
  @company.accounts.create(attributes_for(:account, name: 'Wages payable',
                                                    category: :liabilities))
  @company.accounts.create(attributes_for(:account, name: 'Interest payable',
                                                    category: :liabilities))
end

Given /^I have created an operation$/ do
  @company.operations.create(attributes_for(:operation))
  @operation = @company.operations.order(:created_at).last
end

When /^I add a detail to the operation$/ do
  visit user_company_operation_path(@user, @company, @operation)
  select 'Cash', from: 'Account'
  expect(page).to have_content('Account')
  fill_in 'Amount', with: 500
  click_button 'Add'
  select 'Inventory', from: 'Account'
  fill_in 'Amount', with: 500
  click_button 'Add'
end

Then /^I should see the new detail in the list$/ do
  expect(page).to have_content('Cash')
  expect(page).to have_content('Inventory')
  expect(page).to have_content('500', count: 2)
end

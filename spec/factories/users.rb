FactoryGirl.define do
  factory :user do
    id                    1 
    name                  'John'
    last_name             'Doe'
    email                 'john_doe@example.com'
    password              '0a1b2c3d4e'
    password_confirmation '0a1b2c3d4e'
    
    #factory :user_with_company do
    #  after(:create) do
    #    companies.create(attributes_for(:company))
    #  end
    #end
  end
end

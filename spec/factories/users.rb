FactoryGirl.define do
  factory :user do
    id                    1 
    name                  'John'
    last_name             'Doe'
    email                 'john_doe@example.com'
    password              '0a1b2c3d4e'
    password_confirmation '0a1b2c3d4e'
  end
end

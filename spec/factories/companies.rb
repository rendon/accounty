FactoryGirl.define do
  factory :company do
    name        'Inforscience'
    description 'My imaginary company'
    logo        'inforscience_logo.png'
    factory :company_with_user do
      user_id = 1
    end
  end
end

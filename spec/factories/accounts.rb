FactoryGirl.define do
  factory :account do
    company_id    1
    name          'Cash'
    description   'Money for immediate use'
    category      :assets
    subcategory   :current
  end
end

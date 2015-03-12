FactoryGirl.define do
  factory :account do
    name          'Cash'
    description   'Money for immediate use'
    category      :assets
    subcategory   :current
  end
end

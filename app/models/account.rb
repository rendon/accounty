class Account < ActiveRecord::Base
  belongs_to :company
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, length: { maximum: 1024 }
  validates :category, inclusion: { in: ['assets', 'liabilities'] }
  validates :subcategory, inclusion: { in: ['current', 'long_term'] }
end
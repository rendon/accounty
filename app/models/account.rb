# Account model
class Account < ActiveRecord::Base
  belongs_to :company
  has_many :operation_details
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, length: { maximum: 1024 }
  validates :category, inclusion: { in: %w(assets liabilities) }
  validates :subcategory, inclusion: { in: %w(current long_term) }
  validates :company_id, presence: true

  def asset?
    category == 'assets'
  end
end

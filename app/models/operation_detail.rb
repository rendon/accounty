# OperationDetail model
class OperationDetail < ActiveRecord::Base
  belongs_to :operation
  belongs_to :account
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :account_id, presence: true
  validates :operation_id, presence: true
end

# Operation model
class Operation < ActiveRecord::Base
  belongs_to :company
  has_many :operation_details
  validates :description, presence: true, length: { maximum: 1024 }
  validates :company_id, presence: true
end

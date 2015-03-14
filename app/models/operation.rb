class Operation < ActiveRecord::Base
  belongs_to :company
  validates :description, presence: true, length: { maximum: 1024 }
end

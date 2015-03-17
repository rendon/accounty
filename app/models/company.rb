# Company model
class Company < ActiveRecord::Base
  belongs_to :user
  has_many :accounts
  has_many :operations
  validates :name, presence: true
  validates :user_id, presence: true

  validates :description, presence: true, length: { maximum: 1024 }
  validates_uniqueness_of :name, scope: :user_id
end

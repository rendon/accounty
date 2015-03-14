class Company < ActiveRecord::Base
  belongs_to :user
  has_many :accounts
  has_many :operations
  validates :name, presence: true
  validates :user_id, presence: true
end

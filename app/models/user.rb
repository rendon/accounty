# User model
class User < ActiveRecord::Base
  before_save { self.email.downcase! }
  has_many :companies

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :last_name, presence: true

  has_secure_password
  validates :password, length: { minimum: 8 }, allow_blank: true

  def full_name
    "#{name} #{last_name}"
  end
end

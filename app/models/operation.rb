# Operation model
class Operation < ActiveRecord::Base
  acts_as_xlsx

  belongs_to :company
  has_many :operation_details
  validates :description, presence: true, length: { maximum: 1024 }
  validates :company_id, presence: true

  def ingress
    assets.reduce(0) { |sum, detail| sum + detail.amount }
  end

  def egress
    liabilities.reduce(0) { |sum, detail| sum + detail.amount }
  end

  def balance
    ingress - egress
  end

  private
  
  def assets
    operation_details.select do |detail|
      detail.id && detail.account.category == 'assets'
    end
  end

  def liabilities
    operation_details.select do |detail|
      detail.id && detail.account.category == 'liabilities'
    end
  end
end

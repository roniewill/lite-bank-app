class BankAccount < ApplicationRecord
  belongs_to :user
  
  has_many :transactions

  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true
  validates :user_id, presence: true
  validates :status, inclusion: { in: [ true, false ] }

  before_validation :load_defaults

  def load_defaults
    if self.new_record?
      self.account_number = '%05d' % rand(5 ** 10)
      self.status = true
    end
  end 

end

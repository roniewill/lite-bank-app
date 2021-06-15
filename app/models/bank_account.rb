# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :user

  has_many :transactions

  enum status: [ :active, :inactive ]

  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true
  validates :user_id, presence: true
  validates :status, presence: true

  before_validation :load_defaults

  def load_defaults
    if new_record?
      self.account_number = '%05d' % rand(5**10)
      self.status = "active"
    end
  end
end

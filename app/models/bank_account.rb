# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :user

  has_many :transactions

  enum status: %i[inactive active].freeze

  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true
  validates :user_id, presence: true
  validates :status, presence: true

  before_validation :load_defaults

  def load_defaults
    if new_record?
      self.account_number = '%05d' % rand(5**10)
      self.status = 'active'
    end
  end

  def change_status
    if active? && balance.zero?
      update_attribute :status, 'inactive'
    elsif inactive? && balance >= 0
      update_attribute :status, 'active'
    else
      return false
    end
  end
end

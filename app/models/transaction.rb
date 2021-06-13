# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :bank_account

  TRANSACTION_TYPES = %w[saque depósito transferência].freeze

  validates :bank_account, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }
  validates :transaction_number, presence: true, uniqueness: true

  before_validation :load_defaults

  def load_defaults
    self.transaction_number = SecureRandom.uuid if new_record?
  end
end

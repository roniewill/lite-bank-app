# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :bank_account

  monetize :amount, as: :amount_cents
  monetize :fee, as: :fee_cents

  scope :search_by_date, ->(start_date: nil, end_date: nil) {
    if start_date.present? && end_date.present? then between_dates(start_date: start_date, end_date: end_date)
    elsif start_date.present? && end_date.blank? then starting_on(start_date)
    elsif start_date.blank? && end_date.present? then ending_on(end_date)
    else
      all
    end
  }

  scope :between_dates, ->(start_date:, end_date:) {
    start_at = Date.parse(start_date).beginning_of_day
    end_at = Date.parse(end_date).end_of_day

    where(created_at: start_at..end_at)
  }

  scope :starting_on, ->(date){
    where(created_at: Date.parse(date).beginning_of_day..)
  }

  scope :ending_on, ->(end_date){
    where(created_at: ..Date.parse(date).end_of_day)
  }

  scope :from_account, -> (current_account){
    where(account_sender: current_account.account_number)
    .or(where(bank_account_id: current_account.id)).reverse_order
  }

  TRANSACTION_TYPES = %w[transfer withdraw deposit].freeze

  validates :bank_account_id, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }
  validates :transaction_number, presence: true, uniqueness: true
  validates :account_sender, presence: true

  before_validation :load_defaults

  def load_defaults
    self.transaction_number = SecureRandom.uuid if new_record?
  end
end

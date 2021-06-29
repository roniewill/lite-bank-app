# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    bank_account { create(:bank_account) }
    amount { 500 }
    fee { 0 }
    account_sender { 123_456 }
    transaction_type { 'deposit' }
    transaction_number { 123_456 }
  end
end

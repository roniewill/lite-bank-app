# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    bank_account { create(:bank_account) }
    amount { 500 }
    transaction_type { 'transferência' }
    transaction_number { 123_456 }
  end
end

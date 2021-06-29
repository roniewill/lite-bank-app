# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    account_number { '0000001' }
    balance { 1500 }
    status { 'active' }
    user { create(:user) }
  end
end

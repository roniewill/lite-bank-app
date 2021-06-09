FactoryBot.define do
  factory :bank_account do
    account_number { '0000001' }
    balance { 1500 }
    status { true }
    user { create(:user) }
  end
end
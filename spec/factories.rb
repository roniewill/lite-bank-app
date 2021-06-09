FactoryBot.define do
  
  factory :bank_account do
    number { '0000001' }
    balance { 1500 }
    status { true }
    user_id { 1 }
  end
end
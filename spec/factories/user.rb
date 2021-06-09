FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'admin123' }
    password_confirmation { 'admin123' }
  end
end
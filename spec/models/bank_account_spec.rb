require 'rails_helper'

RSpec.describe BankAccount, :type => :model do
  before (:all) do
    @account = build(:bank_account)
  end

  it "is valid with valid attributes" do
    expect(@account).to be_valid
  end

  it "is not valid without a balance" do
    @account.balance = nil
    expect(@account).to_not be_valid
  end

  it "is not valid without a account number" do
    @account.account_number = '0000001'
    expect(@account).to_not be_valid
  end

end
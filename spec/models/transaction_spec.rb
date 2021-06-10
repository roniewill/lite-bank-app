require 'rails_helper'

RSpec.describe Transaction, :type => :model do
  before (:all) do
    @transaction = build(:transaction)
  end

  it "is valid with valid attributes" do
    expect(@transaction).to be_valid
  end

  it "is not valid without a amount" do
    @transaction.amount = nil
    expect(@transaction).to_not be_valid
  end

  it "is not valid without a amount" do
    @transaction.amount = "cem reais"
    expect(@transaction).to_not be_valid
  end

  it "is not valid without a amount" do
    @transaction.transaction_type = "pagamento"
    expect(@transaction).to_not be_valid
  end

  it "is not valid without a amount" do
    @transaction.transaction_number = 123456
    expect(@transaction).to_not be_valid
  end

  it "is not valid without a amount" do
    @transaction.transaction_number = nil
    expect(@transaction).to_not be_valid
  end

end
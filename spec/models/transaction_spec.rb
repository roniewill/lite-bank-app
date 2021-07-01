# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:all) do
    @transaction = build(:transaction)
  end

  it 'is valid with valid attributes' do
    expect(@transaction).to be_valid
  end

  it 'is not valid without a amount' do
    @transaction.amount = nil
    expect(@transaction).to_not be_valid
  end

  it 'is not valid without a amount' do
    @transaction.amount = 'cem reais'
    expect(@transaction).to_not be_valid
  end

  it 'is not valid without others params' do
    @transaction.transaction_type = 'payment'
    expect(@transaction).to_not be_valid
  end

  it 'is not valid without others params' do
    @transaction.transaction_number = 123_456
    expect(@transaction).to_not be_valid
  end

  it 'is not valid without a transaction number' do
    @transaction.transaction_number = nil
    expect(@transaction).to_not be_valid
  end
end

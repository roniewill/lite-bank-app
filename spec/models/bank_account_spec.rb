require 'rails_helper'

RSpec.describe BankAccount, :type => :model do
  # before (:each) do
  #   @account = create(:bank_account)
  # end
  
  # context "Valid account" do     
  #   it "is valid with a account_number" do
  #     expect(@account).to be_valid
  #   end


describe "#load_defaults" do
    it "sets an account_number before_validate" do
      @account = BankAccount.new
      expect(@account.account_number).to be_nil
      @account.valid?
      expect(@account.account_number).to be_present
    end
  end
end
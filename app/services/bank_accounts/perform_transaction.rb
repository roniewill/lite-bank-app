# frozen_string_literal: true

module BankAccounts
  class PerformTransaction < ApplicationService
    BASE_FEE = 5
    HIGHER_FEE = 7
    ADIOTIONAL_FEE = 10
    BUSINESS_HOURS = (9..18).freeze

    def initialize(transaction_params)
      params = OpenStruct.new(transaction_params)
      @amount = params.amount.to_f
      @transaction_type = params.transaction_type
      @bank_account_id = params.bank_account_id
      @account_sender = BankAccount.find_by(account_number: params.account_sender)
      @receiver_account = BankAccount.find_by(id: @bank_account_id)
      @fee = ::BankAccounts::Fee.call(transaction_type: params.transaction_type,
        amount: params.amount.to_f)
    end

    def call
      ActiveRecord::Base.transaction do
        Transaction.create!(
          bank_account: @receiver_account,
          amount: @amount,
          transaction_type: @transaction_type,
          account_sender: @account_sender.account_number,
          fee: @fee
        )

        case @transaction_type
        when 'withdraw'
          @account_sender.update!(balance: @account_sender.balance.to_f - @amount)
        when 'deposit'
          @account_sender.update!(balance: @account_sender.balance.to_f + @amount)
        when 'transfer'
          @account_sender.update!(balance: (@account_sender.balance.to_f - (@amount + @fee)))
          @receiver_account.update!(balance: @receiver_account.balance.to_f + @amount)
        end
      end

      @account_sender
    end
  end
end

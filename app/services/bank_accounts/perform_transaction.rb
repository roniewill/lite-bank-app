# frozen_string_literal: true

module BankAccounts
  class PerformTransaction < ApplicationService
    def initialize(transaction_params)
      transaction = OpenStruct.new(transaction_params)
      @amount = transaction.amount.to_f
      @transaction_type = transaction.transaction_type
      @bank_account_id = transaction.bank_account_id
      @account_sender = transaction.account_sender
      @bank_account = BankAccount.find_by(account_number: transaction.account_sender)
      @receiver_account = BankAccount.find_by(id: @bank_account_id)
    end

    def call
      ActiveRecord::Base.transaction do
        Transaction.create!(
          bank_account: @bank_account,
          amount: @amount,
          transaction_type: @transaction_type,
          account_sender: @account_sender
        )

        case @transaction_type
        when 'withdraw'
          @bank_account.update!(balance: @bank_account.balance.to_f - @amount)
        when 'deposit'
          @bank_account.update!(balance: @bank_account.balance.to_f + @amount)
        when 'transfer'
          @bank_account.update!(balance: @bank_account.balance.to_f - @amount)
          @receiver_account.update!(balance: @receiver_account.balance.to_f + @amount)
        end
      end

      @bank_account
    end
  end
end

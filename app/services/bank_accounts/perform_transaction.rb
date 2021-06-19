# frozen_string_literal: true

module BankAccounts
  class PerformTransaction
    def initialize(bank_account_id:, amount:, transaction_type:, account_sender:)
      @amount = amount.to_f
      @transaction_type = transaction_type
      @bank_account_id = bank_account_id
      @account_sender = account_sender
      @bank_account = BankAccount.where(account_number: account_sender).first
    end

    def execute!
      ActiveRecord::Base.transaction do
        AccountTransaction.create!(
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
        end
      end

      @bank_account
    end
  end
end

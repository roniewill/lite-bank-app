module BankAccounts
  class ValidateTransaction
    def initialize(bank_account_id:, amount:, transaction_type:, account_sender: )
        @amount = amount.try(:to_i) 
        @transaction_type = transaction_type
        @bank_account_id = bank_account_id
        @bank_account = BankAccount.where(account_number: account_sender).first
        @errors = []
    end

    def call
      validate_existence_of_account!

      if @bank_account.present?
        case @transaction_type
        when "withdraw"
          validate_withdraw!
        when "transfer"
          validate_transfer!
        else
          "non-existent operation"
        end
      end
      @errors
    end

    private

    def validate_withdraw!
      if @bank_account.balance - @amount < 0.00
          @errors << "Saldo insuficiente"
      end
    end

    def validate_transfer!
      if @bank_account.balance - @amount < 0.00
          @errors << "Saldo insuficiente"
      end
    end

    def validate_existence_of_account!
      if @bank_account.blank?
          @errors << "Conta não encontrada"
      end
    end
  end
end

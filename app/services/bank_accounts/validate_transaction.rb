# frozen_string_literal: true

require 'ostruct'

module BankAccounts
  class ValidateTransaction < ApplicationService
    attr_accessor :errors

    def initialize(transaction_params)
      transaction = OpenStruct.new(transaction_params)
      @amount = transaction.amount.try(:to_i)
      @transaction_type = transaction.transaction_type
      @account_receive = BankAccount.find_by(id: transaction.bank_account_id)
      @account_sender = BankAccount.find_by(account_number: transaction.account_sender)
      @errors = []
    end

    def call
      validate_existence_of_account!

      validate_transaction_type!

      validate_amount!

      @errors
    end

    private

    def validate_withdraw!
      @errors << 'Saldo insuficiente' if (@account_sender.balance - @amount).negative?
    end

    def validate_transfer!
      @errors << 'Saldo insuficiente' if (@account_sender.balance - @amount).negative?
    end

    def validate_existence_of_account!
      @errors << 'Conta não encontrada' if @account_receive.nil?
    end

    def validate_amount!
      @errors << 'Valor precisa ser maior que 0' if @amount.zero? || @amount.negative?
    end

    def valide_transfer_when_account_sender_is_same_account_receive!
      if @account_receive.account_number === @account_sender.account_number
        @errors << 'Essa operação não pode ser feita para mesma conta'
      end
    end

    def validate_transaction_type!
      case @transaction_type
      when 'withdraw'
        validate_withdraw!
      when 'transfer'
        validate_transfer!
        valide_transfer_when_account_sender_is_same_account_receive!
      else
        @errors << 'Operação invalida'
      end
    end

    def rate_calculation
      
    end
  end
end

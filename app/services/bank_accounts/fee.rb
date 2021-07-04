# frozen_string_literal: true

module BankAccounts
  class Fee < ApplicationService
    BASE_FEE = 5
    HIGHER_FEE = 7
    ADIOTIONAL_FEE = 10
    BUSINESS_HOURS = (9..18).freeze

    def initialize(amount: nil, transaction_type: nil)
      @amount = amount
      @transaction_type = transaction_type
    end

    def call
      get_fee
    end

    def get_fee
      if @transaction_type == 'transfer'
        return generate_fee + ADIOTIONAL_FEE if @amount >= 1000

        generate_fee
      else
        0
      end
    end

    def generate_fee
      return BASE_FEE if working_hour?(Time.current)

      HIGHER_FEE
    end

    def working_hour?(time)
      time.on_weekday? && time.hour.in?(BUSINESS_HOURS)
    end
  end
end

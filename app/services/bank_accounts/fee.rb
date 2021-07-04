module BankAccounts
  class Fee < ApplicationService
    BASE_FEE = 5
    HIGHER_FEE = 7
    ADIOTIONAL_FEE = 10
    BUSINESS_HOURS = (9..18).freeze

    def self.get_fee transaction_type, amount
      if transaction_type == 'transfer'
        return generate_fee + ADIOTIONAL_FEE if amount >= 1000

        generate_fee
      else
        0
      end
    end

    private

    def generate_fee
      return BASE_FEE if working_hour?(Time.current)

      HIGHER_FEE
    end

    def working_hour?(time)
      time.on_weekday? && time.hour.in?(BUSINESS_HOURS)
    end
  
  end
end
# frozen_string_literal: true

module BankAccountsHelper
  def format_value_BRL(valor)
    number_to_currency(valor, unit: 'R$ ', separator: ',', delimiter: '.')
  end
end

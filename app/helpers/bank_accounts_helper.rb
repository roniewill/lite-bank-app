module BankAccountsHelper

  def format_value_BRL(valor)
    ActionController::Base.helpers.number_to_currency(valor, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end
end

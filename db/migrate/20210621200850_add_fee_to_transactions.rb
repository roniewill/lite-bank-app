# frozen_string_literal: true

class AddFeeToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :fee, :integer, after: :transaction_number
  end
end

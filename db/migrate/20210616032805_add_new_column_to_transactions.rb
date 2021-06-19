# frozen_string_literal: true

class AddNewColumnToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :account_sender, :integer, after: :transaction_type
  end
end

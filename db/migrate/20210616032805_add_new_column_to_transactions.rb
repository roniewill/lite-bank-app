# frozen_string_literal: true

class AddNewColumnToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :account_sender, :string
  end
end

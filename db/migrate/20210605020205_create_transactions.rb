# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :bank_account, null: false
      t.decimal :amount
      t.string :transaction_type
      t.string :transaction_number

      t.timestamps
    end
  end
end

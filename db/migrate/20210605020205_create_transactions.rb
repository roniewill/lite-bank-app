class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :bank_account, null: false, foreign_key: true
      t.decimal :amount
      t.string, :transaction_type
      t.string :transaction_number

      t.timestamps
    end
  end
end

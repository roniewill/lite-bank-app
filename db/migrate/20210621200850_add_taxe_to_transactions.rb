class AddTaxeToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :taxe, :integer
  end
end

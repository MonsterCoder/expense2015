class AddAmountToExpense < ActiveRecord::Migration
  def change
  	add_column :expenses, :amount, :decimal
  end
end

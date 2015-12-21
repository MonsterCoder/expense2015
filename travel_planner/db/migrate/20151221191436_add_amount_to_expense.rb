class AddAmountToExpense < ActiveRecord::Migration
  def change
  	add_column :trips, :amount, :decimal
  end
end

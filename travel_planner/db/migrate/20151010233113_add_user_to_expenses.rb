class AddUserToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :user, index: true

  end
end

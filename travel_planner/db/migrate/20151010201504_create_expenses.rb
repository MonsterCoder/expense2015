class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :destination, null: false
      t.date :startDate, null: false
      t.text  :endDate, null: false
      t.text :comment
      t.timestamps null: false
    end
  end
end

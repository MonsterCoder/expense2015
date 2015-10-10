class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :destination, null: false
      t.date :startDate, null: false
      t.date  :endDate, null: false
      t.text :comment
      t.timestamps null: false
    end
  end
end

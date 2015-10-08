class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email, :string
      t.timestamps null: false
    end
  end
end

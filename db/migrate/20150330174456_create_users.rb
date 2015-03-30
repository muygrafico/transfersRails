class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :balance, default: 50000

      t.timestamps null: false
    end
  end
end

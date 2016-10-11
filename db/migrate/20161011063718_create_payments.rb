class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true, foreign_key: true
      t.string :balance
      t.integer :price
      t.string :description
      t.date :settlement_date

      t.timestamps null: false
    end
  end
end

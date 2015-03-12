class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :company_id
      t.string :name
      t.text :description
      t.string :category
      t.string :subcategory

      t.timestamps null: false
    end
  end
end

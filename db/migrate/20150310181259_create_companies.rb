class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :logo

      t.timestamps null: false
    end
  end
end

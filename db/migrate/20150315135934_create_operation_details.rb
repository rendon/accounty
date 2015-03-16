class CreateOperationDetails < ActiveRecord::Migration
  def change
    create_table :operation_details do |t|
      t.integer :operation_id
      t.integer :account_id
      t.decimal :amount

      t.timestamps null: false
    end
  end
end

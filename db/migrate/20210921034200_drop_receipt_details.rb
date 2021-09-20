class DropReceiptDetails < ActiveRecord::Migration[6.1]
  def change
    drop_table :receipt_details
    remove_column :users, :job_title
    add_column :rooms, :amount_of_people, :integer, default: 0
  end
end

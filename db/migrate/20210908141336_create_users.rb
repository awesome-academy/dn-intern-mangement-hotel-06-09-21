class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :address
      t.boolean :gender
      t.text :description
      t.string :identifier
      t.integer :role, default: 0
  
      t.timestamps
    end
  end
end

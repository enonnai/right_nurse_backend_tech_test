class CreateNurses < ActiveRecord::Migration[5.1]
  def change
    create_table :nurses do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.boolean :verified
      t.integer :sign_in_count
      t.belongs_to :role, foreign_key: true

      t.timestamps
    end
  end
end

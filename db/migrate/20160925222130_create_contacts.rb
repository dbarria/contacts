class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name, limit:100
      t.string :line1, limit:50
      t.string :line2, limit:50
      t.string :city, limit:35
      t.string :state, limit:20
      t.string :zip, limit: 11
      t.string :phone, limit:20
      t.string :phone_number, limit:20
      t.timestamps
    end
  end
end

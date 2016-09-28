class AddFullTextSearch < ActiveRecord::Migration[5.0]
  def change
    add_index :contacts, [:name, :line1, :line2,:city, :state, :zip, :phone], name: 'fulltext_search', type: :fulltext
  end
end

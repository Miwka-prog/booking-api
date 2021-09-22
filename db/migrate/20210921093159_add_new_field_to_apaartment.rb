class AddNewFieldToApaartment < ActiveRecord::Migration[6.1]
  def change
    add_column :apartments, :beds, :integer, default: 0
    add_column :apartments, :bedrooms, :integer, default: 0
    add_column :apartments, :bathrooms, :integer, default: 0
    add_column :apartments, :apartment_type, :integer, default: 0
  end
end

class AddPhotosToApartments < ActiveRecord::Migration[6.1]
  def change
    add_column :apartments, :photos, :json
  end
end

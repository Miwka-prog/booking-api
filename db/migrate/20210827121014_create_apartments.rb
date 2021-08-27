class CreateApartments < ActiveRecord::Migration[6.1]
  def change
    create_table :apartments do |t|
      t.string :description, default: ""
      t.string :country, default: ""
      t.string :city, default: ""
      t.string :address, default: ""
      t.float  :price_per_night

      t.references :user, null: false , foreign_key: true, index: {unique: true }

      t.timestamps
    end
  end
end
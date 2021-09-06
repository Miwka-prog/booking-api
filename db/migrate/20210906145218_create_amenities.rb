class CreateAmenities < ActiveRecord::Migration[6.1]
  def change
    create_table :amenities do |t|
      t.string :name
      t.boolean :available

      t.timestamps
    end
  end
end

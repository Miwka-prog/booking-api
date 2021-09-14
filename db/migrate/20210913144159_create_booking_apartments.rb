class CreateBookingApartments < ActiveRecord::Migration[6.1]
  def change
    create_table :booking_apartments do |t|
      t.references :user, foreign_key: true
      t.references :apartment, foreign_key: true
      t.float :total_price
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end

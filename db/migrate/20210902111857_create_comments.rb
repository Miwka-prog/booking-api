class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, foreign_key: {on_delete: :cascade }, null: false
      t.references :apartment, foreign_key: {on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end

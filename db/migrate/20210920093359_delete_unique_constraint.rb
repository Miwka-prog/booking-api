class DeleteUniqueConstraint < ActiveRecord::Migration[6.1]
  def up
    remove_index :apartments, :user_id
    add_index :apartments, :user_id
  end

  def down
    change_column :apartments, :user_id, :integer, unique: false
  end
end

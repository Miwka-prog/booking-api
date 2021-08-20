class AddDefaultToGenderInUsers < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE users ALTER gender DROP DEFAULT;"
    change_column :users, :gender, :integer, using: 'gender::integer', default: 0
  end

  def down
    change_column :users, :gender, :string, :default => "unknown"
  end

end

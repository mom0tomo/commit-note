class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :latest_sign_in_at, :timestamp
  end
end

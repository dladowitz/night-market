class AddUserIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer, null: false, default: 999999
  end
end

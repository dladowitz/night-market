class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string :name
      t.integer :event_id
      t.boolean :purchased
      t.string :vendor

      t.timestamps
    end
  end
end

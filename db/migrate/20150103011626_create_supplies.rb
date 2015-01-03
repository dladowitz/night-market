class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string  :name
      t.integer :event_id
      t.boolean :purchased
      t.string  :vendor
      t.integer :cost
      t.integer :total_needed


      t.timestamps
    end
  end
end

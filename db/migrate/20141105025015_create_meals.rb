class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string   :category,   null: false
      t.integer  :event_id
      t.integer  :guests
      t.datetime :start

      t.timestamps
    end
  end
end

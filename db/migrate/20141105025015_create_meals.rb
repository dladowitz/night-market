class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string   :category,   null: false
      t.integer  :event_id,   null: false
      t.integer  :cost
      t.integer  :guests
      t.datetime :start
      # t.date     :date
      # t.time     :time
      t.boolean  :ignore_warnings

      t.timestamps
    end
  end
end

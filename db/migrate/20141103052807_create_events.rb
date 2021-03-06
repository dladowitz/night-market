class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :name,           null: false
      t.integer  :guests,         null: false
      t.integer  :user_id
      t.string   :location
      t.date     :start_date
      t.date     :end_date
      t.integer  :budget
      t.boolean  :gluten_free
      t.boolean  :vegetarian
      t.boolean  :vegan

      t.timestamps
    end
  end
end

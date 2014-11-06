class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string  :name,       null: false
      t.integer :meal_id,    null: false
      t.string  :vendor
      t.integer :servings
      t.string  :category
      t.boolean :ordered
      t.boolean :vegetarian
      t.boolean :vegan
      t.boolean :gluten_free
      t.boolean :dairy_free
      t.boolean :needs_ice
      t.string  :transport_method
      t.string  :transport_time

      t.timestamps
    end
  end
end

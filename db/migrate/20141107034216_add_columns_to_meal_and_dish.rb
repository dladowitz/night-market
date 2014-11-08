class AddColumnsToMealAndDish < ActiveRecord::Migration
  def change
    add_column :meals, :ignore_warnings, :boolean
    add_column :dishes, :needs_ordering, :boolean
    add_column :dishes, :ignore_warnings, :boolean
  end
end


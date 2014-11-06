json.array!(@dishes) do |dish|
  json.extract! dish, :id, :vendor, :servings, :category, :ordered, :vegetarian, :vegan, :gluten_free, :dairy_free, :needs_ice, :transport_method, :transport_time
  json.url dish_url(dish, format: :json)
end

require 'rails_helper'

RSpec.describe "dishes/edit", :type => :view do
  before(:each) do
    @dish = assign(:dish, Dish.create!(
      :vendor => "MyString",
      :servings => 1,
      :category => "MyString",
      :ordered => false,
      :vegetarian => false,
      :vegan => false,
      :gluten_free => false,
      :dairy_free => false,
      :needs_ice => false,
      :transport_method => "MyString",
      :transport_time => "MyString"
    ))
  end

  it "renders the edit dish form" do
    render

    assert_select "form[action=?][method=?]", dish_path(@dish), "post" do

      assert_select "input#dish_vendor[name=?]", "dish[vendor]"

      assert_select "input#dish_servings[name=?]", "dish[servings]"

      assert_select "input#dish_category[name=?]", "dish[category]"

      assert_select "input#dish_ordered[name=?]", "dish[ordered]"

      assert_select "input#dish_vegetarian[name=?]", "dish[vegetarian]"

      assert_select "input#dish_vegan[name=?]", "dish[vegan]"

      assert_select "input#dish_gluten_free[name=?]", "dish[gluten_free]"

      assert_select "input#dish_dairy_free[name=?]", "dish[dairy_free]"

      assert_select "input#dish_needs_ice[name=?]", "dish[needs_ice]"

      assert_select "input#dish_transport_method[name=?]", "dish[transport_method]"

      assert_select "input#dish_transport_time[name=?]", "dish[transport_time]"
    end
  end
end

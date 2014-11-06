require 'rails_helper'

RSpec.describe "dishes/index", :type => :view do
  before(:each) do
    assign(:dishes, [
      Dish.create!(
        :vendor => "Vendor",
        :servings => 1,
        :category => "Category",
        :ordered => false,
        :vegetarian => false,
        :vegan => false,
        :gluten_free => false,
        :dairy_free => false,
        :needs_ice => false,
        :transport_method => "Transport Method",
        :transport_time => "Transport Time"
      ),
      Dish.create!(
        :vendor => "Vendor",
        :servings => 1,
        :category => "Category",
        :ordered => false,
        :vegetarian => false,
        :vegan => false,
        :gluten_free => false,
        :dairy_free => false,
        :needs_ice => false,
        :transport_method => "Transport Method",
        :transport_time => "Transport Time"
      )
    ])
  end

  it "renders a list of dishes" do
    render
    assert_select "tr>td", :text => "Vendor".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Transport Method".to_s, :count => 2
    assert_select "tr>td", :text => "Transport Time".to_s, :count => 2
  end
end

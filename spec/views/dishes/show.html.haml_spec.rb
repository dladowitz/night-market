require 'rails_helper'

RSpec.describe "dishes/show", :type => :view do
  before(:each) do
    @dish = assign(:dish, Dish.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Vendor/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Transport Method/)
    expect(rendered).to match(/Transport Time/)
  end
end

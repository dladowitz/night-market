class LandingPagesController < ApplicationController
  def landing
    render layout: "landing/landing_layout"
  end
end

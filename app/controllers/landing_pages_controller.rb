class LandingPagesController < ApplicationController
  def landing
    # render nothing: true, status: 10000
    # render template: "landing_pages/landing"
    # render file: "/Users/david/Documents/repos/test.html"
    # render inline: "<h1> This is it!<h1>"
    # render json: Event.first, content_type: "application/html"
    # render xml: Event.first
    # render js: "alert('Hello Rails');"
    # render body: "raw"
    # render status: 9
    # render content_type: "application/json"
    render layout: "landing/landing_layout"
  end
end

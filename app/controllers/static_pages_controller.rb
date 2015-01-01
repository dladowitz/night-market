class StaticPagesController < ApplicationController
  before_action :require_user

  def home
    add_breadcrumb "Home", root_path

  end
end

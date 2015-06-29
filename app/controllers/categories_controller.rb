class CategoriesController < ApplicationController
  before_action :logged_in_user
  
  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.length.page
  end

  def show
    @categories = Category.all
  end
end

class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.length.page
  end
end

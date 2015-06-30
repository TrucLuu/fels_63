class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, :admin_auth

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.length.page
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.create"
      redirect_to admin_categories_url
    else
      render "new"
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      redirect_to [:admin, @category], notice: t("category.update")
    else
      render "edit"
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name, :content
  end
end

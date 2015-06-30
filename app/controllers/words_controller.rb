class WordsController < ApplicationController
  def index
    @categories = Category.all
    @words = if params[:filter_state].present?
      Word.filter_category(params[:category_id]).send params[:filter_state], current_user
    else
      Word.all
  end
  end
end

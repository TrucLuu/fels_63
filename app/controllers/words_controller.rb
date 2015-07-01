class WordsController < ApplicationController
  def index
    @categories = Category.all
    @words = if params[:search].present? || params[:filter_state].present?
      Word.filter_category(params[:category_id]).search(params[:search]).send params[:filter_state], current_user
    else
      Word.all
    end

    respond_to do |format|
      format.html
      format.csv {send_data @words.to_csv}
    end
  end
end

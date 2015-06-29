class WordsController < ApplicationController
  before_action :word_set

  def index
    @categories = Category.all
    @words = if params[:search].present? || params[:filter_state].present?
      Word.filter_category(params[:category_id]).search(params[:search])
      .paginate(page: params[:page], per_page: Settings.length.page)
      .send params[:filter_state], current_user
    else
      Word.paginate page: params[:page], per_page: Settings.length.page
    end

    respond_to do |format|
      format.html
      format.csv {send_data @words.to_csv}
    end
  end

  def show
  end
end

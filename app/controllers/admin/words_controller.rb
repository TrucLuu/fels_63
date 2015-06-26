class Admin::WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :admin_auth
  before_action :get_categories, only: [:new, :edit]

  def index
    @words = Word.paginate page: params[:page], per_page: Settings.length.page
  end

  def show
    @category = Category.all
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def create
    @word = Word.new word_params
      if @word.save
        redirect_to  [:admin, @word], notice:  'Word was successfully created.'
      else
        render "new"
      end
  end

  def update
      if @word.update_attributes word_params
        redirect_to @word, notice: 'Word was successfully updated.'
      else
        render "edit"
      end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "admin.user.update.delete_success"
    else
      flash[:danger] = t "admin.user.update.delete_failed"
    end
    redirect_to admin_words_url
  end

  private
  def get_categories
    @categories = Category.all
  end

  def set_word
      @word = Word.find params[:id]
    end

    def word_params
      params.require(:@word).permit(:content, :category_id)
    end
end

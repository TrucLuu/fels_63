class LessonsController < ApplicationController
  before_action :logged_in_user

  MAX_WORD = Settings.length.words

  def show
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
  end

  def index
    @user = User.find current_user
    @lesson = @user.lessons
  end

  def new
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build user_id: current_user.id
    @words = @category.words.random_words current_user
    if @words.count < MAX_WORD
      flash[:danger] = I18n.t "not-enough-word"
      redirect_to categories_path
    else
      MAX_WORD.times do |n|
        @result = @lesson.results.build
        @result.word = @words[n]
      end
    end
  end

  def create
    @category = Category.find_by params[:category_id]
    @lesson = @category.lessons.build lesson_params
    @lesson.user_id = current_user.id

    if @lesson.save
      redirect_to category_lesson_path @category, @lesson, check: 1
    else
      flash[:danger] = I18n.t "not-enough-word"
      redirect_to :back
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit results_attributes: [:word_id, :answer_id]
  end
end

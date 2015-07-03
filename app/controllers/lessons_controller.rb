class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :lesson_set, only: [:show, :edit, :update]
  MAX_WORD = Settings.length.words

  def index
    @user = User.find current_user
    @lesson = @user.lessons
  end

  def show
    @lesson = Lesson.find params[:id]
    @lesson_words = @lesson.results
  end

  def create # cai tao 20 word o dau model model n
    @category = Category.find_by params[:category_id]
    @lesson = current_user.lessons.build category: @category
    if @lesson.save
      redirect_to edit_lesson_path @lesson
    else
      flash[:danger] = I18n.t "not-enough-word"
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @lesson.update_attributes(lesson_params)
      redirect_to lesson_path @lesson, check: 1
    else
      flash[:error] = I18n.t "not-answer-yet"
      redirect_to :back
    end
  end

  private
  def lesson_set
    @lesson = Lesson.find params[:id]
    @category = @lesson.category
  end

  def lesson_params
    params.require(:lesson).permit :category_id, results_attributes: [:id, :answer_id]
  end
end



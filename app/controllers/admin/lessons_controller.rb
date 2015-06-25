class Admin::LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :admin_auth

  def index
    @lessons = Lesson.all
  end

  def show
  end

  def new
    @lesson = Lesson.new
  end

  def edit
  end

  def create
    @lesson = Lesson.new lesson_params
    if @lesson.save
      redirect_to [:admin, @lesson], notice: t("admin.lesson_label.update_success.update_success")
    else
      render "new"
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to [:admin, @lesson], notice: t("admin.lesson_label.update_success.update_success")
    else
      render "edit"
    end
  end

  def destroy
    @lesson.destroy
    redirect_to admin_lessons_url, notice: t("admin.lesson_label.destroy")
  end

  private
  def set_lesson
    @lesson = Lesson.find params[:id]
  end

  def lesson_params
    params.require(:@lesson).permit(:name, :content, :image, :category_id)
  end
end

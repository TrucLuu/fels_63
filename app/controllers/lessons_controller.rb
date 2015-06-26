class LessonsController < ApplicationController
  def index
    @lessons = Lesson.paginate page: params[:page], per_page: Settings.length.page
  end
end

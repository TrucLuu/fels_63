class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @lessons = Lesson.follow_learned(current_user).paginate page: params[:page],
        per_page: Settings.length.page
      redirect_to user_path current_user
    end
  end

  def about
  end

  def help
  end

  def contact
  end
end

class ResultsController < ApplicationController
  before_action :logged_in_user

  def show
    @result = Result.find params[:id]
    @answers = Answer.result_answer @result.lesson
  end
end

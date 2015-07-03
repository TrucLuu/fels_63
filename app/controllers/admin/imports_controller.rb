class Admin::ImportsController < ApplicationController
  def create
    Word.import params[:file]
    redirect_to admin_words_path
  end
end

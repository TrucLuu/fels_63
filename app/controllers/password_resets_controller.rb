class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "reset-send"
      redirect_to root_url
    else
      flash.now[:danger] = t "reset-dont-send"
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      log_in @user
      flash[:success] = t "pass-reset"
      redirect_to @user
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "pass-expired"
      redirect_to new_password_reset_url
    end
  end
end

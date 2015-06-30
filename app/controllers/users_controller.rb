class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.length.page
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
    @lessons = Lesson.follow_learned(@user).order_desc.paginate page: params[:page],
      per_page: Settings.length.page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t "welcome"
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes user_params
      redirect_to [:admin, @user], notice: t("admin.user.update.success")
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def set_user
    @user = User.find params[:id]
  end

  def correct_user
    @users = User.find params[:id]
    redirect_to root_url if current_user? @user
  end
end

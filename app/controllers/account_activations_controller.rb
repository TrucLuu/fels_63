class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.active? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "account-active"
    else 
      flash[:danger] = t "invalid"
    end
    redirect_to root_url
  end
end

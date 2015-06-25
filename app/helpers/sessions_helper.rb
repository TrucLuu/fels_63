module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find user_id
    elsif user_id = cookies.signed[:user_id]
      user = User.find user_id
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user? user
    user == current_user
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login.require"
      redirect_to login_url
    end
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end

def admin_auth
  logged_in_user
  unless current_user.is_admin?
    redirect_to root_url, danger: t("admin.not_authenticated")
  end
end
class Admin::DashbroadsController < ApplicationController
  before_action :logged_in_user, :admin_auth

  def index
  end
end

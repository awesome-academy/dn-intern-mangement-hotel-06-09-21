class Admin::AdminsController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.all
  end
end

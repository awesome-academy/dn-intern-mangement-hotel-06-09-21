class  Admin::AdminsController < ApplicationController
  before_action :logged_in_user, :require_admin
  
end

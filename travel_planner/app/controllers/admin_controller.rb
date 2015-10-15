class AdminController < ApplicationController
  before_filter :require_admin_role
  
  def index
    render json: {}
  end
  
end

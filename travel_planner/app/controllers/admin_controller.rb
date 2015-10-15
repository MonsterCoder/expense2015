class AdminController < ApplicationController
  before_filter :require_admin_role
  
  def index
    render json: {}
  end
  
  def require_admin_role
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_user_by_token token
    end
  end
end

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  it " assigns logged user in controller" do
    @request.headers["Content-Type"] = 'application/json'
    @request.headers["Authorization"] = "Token token=#{User.getAdminToken}"
    get :index, {user_id: user.id }
  end
end

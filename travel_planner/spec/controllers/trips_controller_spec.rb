require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  
  it " assigns logged user in controller" do
    @request.headers["Content-Type"] = 'application/json'
    @request.headers["Authorization"] = "Token token=#{user.getToken}"
    get :index
    expect(assigns(:current_user)).to eq(user)
  end
  
  context " admin inpersonate a user" do
    it " assign current user as specified" do
      @request.headers["Content-Type"] = 'application/json'
      @request.headers["Authorization"] = "Token token=#{User.getAdminToken}"
      get :index, user_id: user.id
      expect(assigns(:current_user)).to eq(user)
    end
  end
end

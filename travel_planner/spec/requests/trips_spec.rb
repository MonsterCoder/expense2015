require 'rails_helper'

describe "trips" do
  before :all do
    @user = FactoryGirl.create(:user)
  end
  
  it " requires login to access" do
    get trips_path(@user.id)
    expect(response.status).to equal 401
  end
  
  describe "CRUD" do
    
    let(:headers) { { 'Content-Type' => 'application/json', 'Authorization' => "Token token=#{@user.getToken}"} }
    
    it " returns all trips " do
      get trips_path(@user.id), nil, headers
      expect(response.status).to equal 200
    end 
  end
end
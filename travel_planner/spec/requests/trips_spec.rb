require 'rails_helper'

describe "trips" do
  before :all do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
  end
  
  it " requires login to access" do
    get trips_path(@user1.id)
    expect(response.status).to equal 401
  end
  
  describe "CRUD" do
    
    let(:headers) { { 'Content-Type' => 'application/json', 'Authorization' => "Token token=#{@user1.getToken}"} }
    
    it " returns all trips " do
      3.times { FactoryGirl.create(:trip, user: @user1)}
      get trips_path, nil, headers
      expect(response.status).to equal 200 
      expect(JSON.parse(response.body)["trips"].count).to equal 3
    end 
    
    it " creates a trip " do
      t = FactoryGirl.build(:trip, user: @user1)
      expect{post trips_path, {data: t}.to_json, headers}.to change(Trip, :count).by 1
      expect(response.status).to equal 200 
      
    end
    
    it " updates a trip " do
      t = FactoryGirl.create(:trip, user: @user1)
      put trip_path(t), {data: { destination: 'abc'}}.to_json, headers
      expect(response.status).to equal 200 
      t.reload
      expect(t.destination).to eq 'abc'

      
    end
    
    it " delete a trip " do
      t = FactoryGirl.create(:trip, user: @user1)
      expect{ delete trip_path(t), {}, headers}.to change(Trip, :count).by -1
      expect(response.status).to equal 200 
      
    end
    
  end
end
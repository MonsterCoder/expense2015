require 'rails_helper'

RSpec.describe 'admin', type: :request do
  describe "#create" do
    let(:new_user) { FactoryGirl.build(:user, password: '123456', password_confirmation: '123456')}
    let(:data)  { {
      firstname: new_user.firstname, 
      lastname: new_user.lastname, 
      username: new_user.username, 
      email: new_user.email, 
      password: '123456', 
      password_confirmation: '123456'
    } }
    context "valid attributes" do
      xit "creates a new user" do
        expect{ post users_path, {  user: data }.to_json, { 'Content-Type': 'application/json'} }.to change(User, :count).by(1)
        expect(response).to be_ok
        
      end
    end
    
    
    context "invalid attributes" do
      xit "rejects request and returns correct error" do
        data['password_confirmation'] ='890000'
         expect{ post users_path, {  user: data }.to_json, { 'Content-Type': 'application/json'} }.to change(User, :count).by(0)
         expect(response.status).to eq(400)
      end
    end

  end
end
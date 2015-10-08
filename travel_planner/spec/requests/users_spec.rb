require 'rails_helper'

RSpec.describe 'account', type: :request do
  describe "#create" do
    let(:new_user) { FactoryGirl.build(:user, password: '123456', password_confirmation: '123456')}
    context "valid attributes" do
      it "creates a new user" do
        
        data = {
          firstname: new_user.firstname, 
          lastname: new_user.lastname, 
          username: new_user.username, 
          email: new_user.email, 
          password: '123456', 
          password_confirmation: '123456'
        }
        
        expect{ post users_path, {  user: data }.to_json, { 'Content-Type': 'application/json'} }.to change(User, :count).by(1)
        expect(response).to be_ok
        
      end
    end
    
    
    context "invalid attributes" do
      let(:data)  { {
        firstname: new_user.firstname, 
        lastname: new_user.lastname, 
        username: new_user.username, 
        email: new_user.email, 
        password: '123456', 
        password_confirmation: '6543271'
      } }
      
      it "rejects request and returns correct error" do
         expect{ post users_path, {  user: data }.to_json, { 'Content-Type': 'application/json'} }.to change(User, :count).by(0)
         expect(response.status).to eq(400)
      end
    end

  end
end
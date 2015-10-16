require 'rails_helper'

RSpec.describe 'admin', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json', 'Authorization' => "Token token=#{User.getAdminToken}"} }
  describe "#user accounts " do
    let!(:user) { FactoryGirl.create(:user, password: 'abcd', password_confirmation: 'abcd')}
    let(:new_user) { FactoryGirl.build(:user, password: '123456', password_confirmation: '123456')}
    let(:data)  { {
      firstname: new_user.firstname, 
      lastname: new_user.lastname, 
      username: new_user.username, 
      email: new_user.email, 
      password: '123456', 
      password_confirmation: '123456'
    } }
    context "access restriction" do
      it " requires admin role" do
        get "/admin"
        expect(response.status).to equal 401
      end
      
      it " allows access for admin user" do
        get "/admin", {}, headers
        expect(response.status).to equal 200
      end
    end
    
    context "CRUD users account" do
      it "creates a new user" do
        expect{ post users_path, {  user: data }.to_json, { 'Content-Type': 'application/json'} }.to change(User, :count).by(1)
        expect(response).to be_ok
        
      end
      
      it "update a new user's password" do
        put user_path(user), { user_id: user.id, user: {password: "no_rest", password_confirmation: "no_rest" }}.to_json, headers
        expect(response).to be_ok
        user.reload
        expect(user.authenticate("no_rest")).to be_truthy
        
      end
      
      it "removes a  user" do
        expect{ delete user_path(user), { user_id: user.id }.to_json, headers }.to change(User, :count).by(-1)
        expect(response).to be_ok
        
      end
    end
  end
end
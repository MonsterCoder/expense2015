require 'rails_helper'

describe 'authentication' do
  context "regular user login" do
    before :all do
      @user = FactoryGirl.create(:user, username: 'u1', password: '123')
    end
    
    it (" returns 401 when login failed") do
      post auth_path, { username: 'u1', password: 'aaa'}.to_json, {'content-type': 'application/json'}
      expect(response.status).to eql 401
    end
    
    it (" returns a token when login succeed") do
      post auth_path, { username: 'u1', password: '123'}.to_json, {'content-type': 'application/json'}
      token = JSON.parse(response.body)["token"]
      user_id = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]['user_id']
      expect(response.status).to eql 200
      expect(user_id).to eql @user.id
    end
  end
  
  context "admin user login" do
    before :all do
    
    end
    
    it (" returns 401 when login failed") do
      stub_const('ENV', {'TP_ADMIN_PASSWORD' => 'a1b2ce'})
      post auth_path, { username: 'admin', password: 'aaa'}.to_json, {'content-type': 'application/json'}
      expect(response.status).to eql 401
    end
    
    it (" returns a token when login succeed") do
      stub_const('ENV', {'TP_ADMIN_PASSWORD' => 'a1b2ce'})
      post auth_path, { username: 'admin', password: 'a1b2ce'}.to_json, {'content-type': 'application/json'}
      token = JSON.parse(response.body)["token"]
      user_id = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]['user_id']
      role = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]['role']
      expect(response.status).to eql 200
      expect(user_id).to eql Constants::ADMIN_ID
      expect(role).to eql 'admin'
    end
  end
  
  
end
class User < ActiveRecord::Base
  has_secure_password
  has_many :trips
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true

  def getToken
    JWT.encode({user_id: id}, Rails.application.secrets.secret_key_base)
  end
  
  def self.isAdmin(token)
    Constants::ADMIN_ID == JWT.decode(token, Rails.application.secrets.secret_key_base)[0]['user_id']
  end
  
  def self.find_user_by_token(token)
    user_id = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]['user_id']
    User.find_by_id user_id
  end
  
  def self.getAdminToken
    JWT.encode({user_id: Constants::ADMIN_ID, role: Roles::ADMIN}, Rails.application.secrets.secret_key_base)
  end
  
end

module Constants
  ADMIN_USERNAME =  'admin'
  ADMIN_ID= 999999
end

module Roles
  ADMIN='admin'
end
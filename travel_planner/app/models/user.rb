class User < ActiveRecord::Base
  has_secure_password
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
  
  def getToken
    JWT.encode({user_id: id}, Rails.application.secrets.secret_key_base)
  end
end

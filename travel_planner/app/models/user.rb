class User < ActiveRecord::Base
  has_secure_password
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :username, presence: true
  validates :email, uniqueness: true
end

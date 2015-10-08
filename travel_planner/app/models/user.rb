class User < ActiveRecord::Base
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :username, presence: true
  validates :email, uniqueness: true
end

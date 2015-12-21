class Trip < ActiveRecord::Base
  belongs_to :user
  validates :destination, presence: true
  validates :startDate, presence: true
  validates :endDate, presence: true

  

end

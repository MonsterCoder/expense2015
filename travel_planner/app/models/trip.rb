class Trip < ActiveRecord::Base
 validates :destination, presence: true
 validates :startDate, presence: true
 validates :endDate, presence: true
 validate :endDate_greater_thant_start_date
 
 def endDate_greater_thant_start_date
   if startDate && endDate && (startDate > endDate)
     errors.add(:endDate, "end date must be greater than start date")
   end
 end
end

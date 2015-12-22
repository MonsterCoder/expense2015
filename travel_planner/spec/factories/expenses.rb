FactoryGirl.define do
  factory :trip do
    destination {Faker::Address.city}
    startDate { Date.today }
    endDate { Date.today + 1.day }
  end

end

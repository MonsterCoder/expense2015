FactoryGirl.define do
  factory :trip do
    destination {Faker::Address.city}
    startDate { 1.day }
    endDate { 1.day }
  end

end

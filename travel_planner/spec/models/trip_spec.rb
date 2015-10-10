require 'rails_helper'

RSpec.describe Trip, type: :model do
  it " has a valide factory " do
    expect(FactoryGirl.build(:trip)).to be_valid
  end
  
  it " requires a destination" do
    expect(FactoryGirl.build(:trip, destination: nil)).not_to be_valid
  end
  
  it " requires a start date" do
    expect(FactoryGirl.build(:trip, startDate: nil)).not_to be_valid
  end
  
  it " requires a start date" do
    expect(FactoryGirl.build(:trip, endDate: nil)).not_to be_valid
  end
  
  it " requires end date after start date" do
    expect(FactoryGirl.build(:trip, endDate: 1.day, startDate: 2.day)).not_to be_valid
  end
end

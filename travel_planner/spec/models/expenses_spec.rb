require 'rails_helper'

RSpec.describe Expense, type: :model do
  before :all do
    @user = FactoryGirl.create(:user)
  end
  
  before :each do
    @trip = FactoryGirl.build(:trip, user: @user)
  end
  
  it " has a valide factory " do
    expect(@trip).to be_valid
  end
  
  it " requires a destination" do
    @trip.destination = nil
    expect(@trip).not_to be_valid
  end
  
  it " requires a start date" do
    @trip.startDate = nil
    expect(@trip).not_to be_valid
  end
  
  it " requires a start date" do
    @trip.endDate = nil
    expect(@trip).not_to be_valid
  end
  
  it " requires end date after start date" do
    expect(FactoryGirl.build(:trip,user: @user, endDate: 1.day, startDate: 2.day)).not_to be_valid
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it " validates firstname exist" do
    expect(FactoryGirl.build(:user, firstname: nil)).to_not be_valid
  end
  
  it " validates lastname exist" do
    expect(FactoryGirl.build(:user, lastname: nil)).to_not be_valid
  end
  
  it " validates username  exist" do
    expect(FactoryGirl.build(:user, username: nil)).to_not be_valid
  end
  
  it " has unique emaill address " do
    FactoryGirl.create(:user, email: 'abc@gmail.com')
    expect(FactoryGirl.build(:user , email: 'abc@gmail.com')).to_not be_valid
  end
end

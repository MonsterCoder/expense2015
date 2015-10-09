require 'rails_helper'

RSpec.describe User, type: :model do
  it " has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  
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
  
  context "password" do
    it " has confirmation for password " do
      expect(FactoryGirl.build(:user , password: '123456', password_confirmation: '123456')).to be_valid
    end

    it " validates password confirmation" do
      expect(FactoryGirl.build(:user , password: '123456', password_confirmation: '1234567')).to_not be_valid
    end
    context "authenticate password" do
      subject { FactoryGirl.create(:user, password: '123456', password_confirmation: '123456') }
      it " authenticates with correct password " do
        expect(subject.authenticate '123456').to be_truthy
      end
      
      it " rejects with incorrect password " do
        expect(subject.authenticate '1234567').to be_falsey
      end
    end
  end
end

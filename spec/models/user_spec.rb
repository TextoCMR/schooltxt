require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", :phone => "3193857101" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require a phone number" do
    no_phone_user = User.new(@attr.merge(:phone => ""))
    no_phone_user.should_not be_valid
  end
  
  it "should reject looooooong user names" do
    long_name = "jm" * 101
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid phone numbers" do
    phone_numbers = ['319-385-7101','3193857101','(319) 385-7101', '+1(319)-385-7101']
    phone_numbers.each do |phone|
      valid_phone_user = User.new(@attr.merge(:phone => phone))
      valid_phone_user.should be_valid
    end
  end
  
  it "should reject invalid phone numbers" do
    phone_numbers = ['+44 149 25 25 25','911']
    phone_numbers.each do |phone|
      valid_phone_user = User.new(@attr.merge(:phone => phone))
      valid_phone_user.should_not be_valid
    end
  end
  
  it "should reject repeat phone numbers" do
    User.create!(@attr)
    user_with_dup_phone = User.new(@attr)
    user_with_dup_phone.should_not be_valid
  end
end
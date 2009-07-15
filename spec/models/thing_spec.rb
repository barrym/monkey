require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Thing do
  before(:each) do
    @user = Factory.create(:user)

    @valid_attributes = {
      :user => @user
    }
  end

  it "should create a new instance given valid attributes" do
    Thing.create!(@valid_attributes)
  end

  it "should belong to a user" do
    thing = Thing.new(:user => @user)
    thing.user.should == @user
  end

  it "should require a user" do
    thing = Thing.new
    thing.should_not be_valid
    thing.should have(1).error_on(:user)

    thing.user = @user
    thing.should be_valid
  end

  it "should require a folder"

end

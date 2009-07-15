require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Thing do
  before(:each) do
    @user = Factory.create(:user)
    @folder = Factory.create(:folder)
  end

  it "should belong to a user" do
    thing = Thing.new(:user => @user)
    thing.user.should == @user
  end

  it "should require a user" do
    thing = Factory.build(:thing, :user => nil)
    thing.should_not be_valid
    thing.should have(1).error_on(:user)

    thing.user = @user
    thing.should be_valid
  end

  it "should belong to a folder" do
    thing = Thing.new(:folder => @folder)
    thing.folder.should == @folder
  end

  it "should require a folder" do
    thing = Factory.build(:thing, :folder => nil)
    thing.should_not be_valid
    thing.should have(1).error_on(:folder)

    thing.folder = @folder
    thing.should be_valid
  end

end

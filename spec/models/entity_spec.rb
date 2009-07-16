require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Entity do
  before(:each) do
    @user = Factory.create(:user)
    @folder = Factory.create(:folder)
  end

  it "should belong to a user" do
    entity = Entity.new(:user => @user)
    entity.user.should == @user
  end

  it "should require a user" do
    entity = Factory.build(:entity, :user => nil)
    entity.should_not be_valid
    entity.should have(1).error_on(:user)

    entity.user = @user
    entity.should be_valid
  end

  it "should belong to a folder" do
    entity = Entity.new(:folder => @folder)
    entity.folder.should == @folder
  end

  it "should require a folder" do
    entity = Factory.build(:entity, :folder => nil)
    entity.should_not be_valid
    entity.should have(1).error_on(:folder)

    entity.folder = @folder
    entity.should be_valid
  end

end

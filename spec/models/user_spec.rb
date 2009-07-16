require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  it "should have a name" do
    @user = Factory.build(:user, :name => "barrym")
    @user.name.should == "barrym"
    @user.should be_valid
  end

  it "should display name as display name if set" do
    @user = Factory.build(:user, :name => "barrym")
    @user.display_name.should == "barrym"
  end

  it "should display email as display name if name isn't set" do
    @user = Factory.build(:user, :name => nil)
    @user.display_name.should == "barry.mitchelson@gmail.com"
  end

  it "should have many entities" do
    @user = Factory.create(:user)
    @user.entities.should == []

    entity = Factory.create(:entity)
    @user.entities << entity
    @user.entities.should == [entity]
  end

  it "should have many folders" do
    @user = Factory.create(:user)
    @user.folders.should == []

    folder = Factory.create(:folder)
    @user.folders << folder
    @user.folders.should == [folder]
  end

end

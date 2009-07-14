require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Folder do
  before(:each) do
    @user = User.create(:email => "barry.mitchelson@gmail.com", :password => "foo")
    @valid_attributes = {
      :name => "My awesome folder",
      :user => @user
    }
  end

  it "should create a new instance given valid attributes" do
    Folder.create!(@valid_attributes)
  end

  it "requires a name" do
    folder = Folder.new(:user => @user)
    folder.should_not be_valid
    folder.should have(1).error_on(:name)

    folder.name = "This is a folder"
    folder.should be_valid
  end

  it "belongs to a user" do
    folder = Folder.create(@valid_attributes)
    folder.user.should == @user

    @user.folders.should == [folder]
  end

  it "requires a user" do
    folder = Folder.new(:name => "My folder")
    folder.should_not be_valid
    folder.should have(1).error_on(:user)

    folder.user = @user
    folder.should be_valid
  end

end

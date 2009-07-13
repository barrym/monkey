require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  def valid_params
    {
      :email    => "barry.mitchelson@gmail.com",
      :password => "foo"
    }
  end

  it "should have a name" do
    @user = User.new(valid_params.merge( :name => "barrym" ))
    @user.name.should == "barrym"
    @user.should be_valid
  end

  it "should display name as display name if set" do
    @user = User.create(valid_params.merge( :name => "barrym" ))
    @user.display_name.should == "barrym"
  end

  it "should display email as display name if name isn't set" do
    @user = User.create(valid_params)
    @user.display_name.should == "barry.mitchelson@gmail.com"
  end

end

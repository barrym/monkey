require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EntityAttribute do
  before(:each) do
    @valid_attributes = {

    }
  end

  it "should create a new instance given valid attributes" do
    EntityAttribute.create!(@valid_attributes)
  end
end

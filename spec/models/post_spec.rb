require 'spec_helper'

describe Post do

  it "should have valid factory" do
    FactoryGirl.build(:post).should be_valid
  end

  it "should require a title" do
    FactoryGirl.build(:post, title: "").should_not be_valid
  end

end

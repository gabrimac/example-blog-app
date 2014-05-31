require 'spec_helper'

describe Comment do

  it "should have valid factory" do
    FactoryGirl.build(:comment).should be_valid
  end

  it "should require a comment" do
    FactoryGirl.build(:comment, comment: "").should_not be_valid
  end

  it "should require a comment" do
    FactoryGirl.build(:comment, username: "").should_not be_valid
  end

  it "should belongs to a post" do
    should belong_to(:post)
  end

end

require 'spec_helper'

describe CommentsController do

  describe "POST create" do

    before :each do
      @post = FactoryGirl.create(:post)
    end

    context "with valid attributes" do
      it "creates a new comment for the current post" do
        expect{
          post :create, post_id: @post.id, comment: FactoryGirl.attributes_for(:comment), format: :js
        }.to change(@post.comments, :count).by(1)
      end

      it "renders the create js template" do
        post :create, post_id: @post.id, comment: FactoryGirl.attributes_for(:comment), format: :js
        response.should render_template :create
      end
    end

    context "with invalid attributes" do
      it "not creates the new comment for the current post" do
        expect{
          post :create, post_id: @post.id, comment: FactoryGirl.attributes_for(:invalid_comment), format: :js
        }.to_not change(Post, :count)
      end

      it "renders the error_create js template" do
        post :create, post_id: @post.id, comment: FactoryGirl.attributes_for(:invalid_comment), format: :js
        response.should render_template :error_create
      end

    end

  end

  describe "DELETE destroy" do

    before :each do
      @post = FactoryGirl.create(:post)
      @comment = FactoryGirl.create(:comment)
      @post.comments << @comment
    end

    it "deletes the comment" do
      expect{
        delete :destroy, post_id: @post, id: @comment.id, format: :js
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to index template" do
      delete :destroy, post_id: @post, id: @comment.id, format: :js
      response.should render_template :destroy
    end
  end

end

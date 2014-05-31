require 'spec_helper'

describe PostsController do

  describe "GET index" do

    it "populates an array of posts with publication date <= date right now" do
      post = FactoryGirl.create(:post, publication_date: Time.now)
      get :index
      assigns(:posts).should eq([post])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end

  end

  describe "GET show" do

    it "assigns the requested post to @post" do
      post = FactoryGirl.create(:post)
      get :show, id: post
      assigns(:post).should eq(post)
    end

    it "assigns the comments of the post in @comments" do
      post = FactoryGirl.create(:post)
      comment1 = FactoryGirl.create(:comment)
      comment2 = FactoryGirl.create(:comment)
      post.comments << comment1
      post.comments << comment2
      get :show, id: post
      assigns(:comments).should eq([comment1, comment2])
    end

    it "assigns a new comment to @new_comment" do
      post = FactoryGirl.create(:post)
      get :show, id: post
      assigns(:new_comment).should be_a_new(Comment)
    end

    it "renders the :show view" do
      post = FactoryGirl.create(:post)
      get :show, id: post.id
      response.should render_template :show
    end

  end

  describe "GET new" do

    it "assigns a new post as @post" do
      get :new
      assigns(:post).should be_a_new(Post)
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end

  end

  describe "GET edit" do

    it "assigns the requested post as @post" do
      post = FactoryGirl.create(:post)
      get :edit, id: post
      assigns(:post).should eq(post)
    end

    it "renders the :edit view" do
      post = FactoryGirl.create(:post)
      get :edit, id: post.id
      response.should render_template :edit
    end

  end

  describe "POST create" do

    context "with valid attributes" do
      it "creates a new post" do
        expect{
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change(Post, :count).by(1)
      end

      it "redirects to the new post" do
        post :create, post: FactoryGirl.attributes_for(:post)
        response.should redirect_to Post.last
      end
    end

    context "with invalid attributes" do
      it "not creates the new post" do
        expect {
          post :create, post: FactoryGirl.attributes_for(:invalid_post)
        }.to_not change(Post, :count)  
      end

      it "renders the new template again" do
        post :create, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :new
      end
    end

  end

  describe "PUT update" do

    before :each do
      @post = FactoryGirl.create(:post, title: "my new post", body: "Joni Ernst’s unconventional campaign for the Senate in Iowa has included ads highlighting her farm experience castrating hogs and being introduced at rallies by Mitt Romney")
    end

    context "with valid params" do
      it "located the requested @post" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post)
        assigns(:post).should eq(@post)
      end

      it "changes @post's attributes" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: "updated post", body: "Hackers seeking information about Washington’s elite posed as John R. Bolton, a former American ambassador, to friend online users through social media.")
        @post.reload
        @post.title.should eq("updated post")
        @post.body.should eq("Hackers seeking information about Washington’s elite posed as John R. Bolton, a former American ambassador, to friend online users through social media.")
      end

      it "redirects to the updated post" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post)
        response.should redirect_to @post
      end
    end
  

    context "with invalid params" do
      it "locates the requested @post" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
        assigns(:post).should eq(@post)
      end

      it "doesn`t change @post`s attributes" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: nil, body: "Hackers seeking information about Washington’s elite posed as John R. Bolton, a former American ambassador, to friend online users through social media.")
        @post.reload
        @post.title.should_not eq("updated post")
        @post.body.should eq("Joni Ernst’s unconventional campaign for the Senate in Iowa has included ads highlighting her farm experience castrating hogs and being introduced at rallies by Mitt Romney")
      end

      it "renders the edit template again" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :edit
      end
    end

  end

  describe "DELETE destroy" do

    before :each do
      @post = FactoryGirl.create(:post)
    end

    it "deletes the post" do
      expect{
        delete :destroy, id: @post
      }.to change(Post, :count).by(-1)
    end

    it "redirects to index template" do
      delete :destroy, id: @post
      response.should redirect_to posts_url
    end

  end

end
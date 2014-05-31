class Post < ActiveRecord::Base

  validates :title, presence: true

	has_many :comments

  before_save :create_publication_date

  def create_publication_date
    if !self.publication_date
      self.publication_date = Time.now
    end
  end

  def show_publication_date
    self.publication_date.strftime("%d/%m/%Y")
  end

  def self.get_publicated_posts
    posts = Array.new
    Post.all.each do |post|
      if post.publication_date <= Time.now
        posts << post
      end
    end
    posts
  end

end

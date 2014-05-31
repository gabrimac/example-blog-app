class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :publication_date, presence: true

	has_many :comments

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

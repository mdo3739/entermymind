class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true

  default_scope { order(:id)}

  # Class method returns a list of topics
  def self.search(search, user)
    final_product = []
    by_topic_name = user.topics.where('name ILIKE ?', "%#{search}%")
    by_topic_name.each do |topic|
      final_product << topic
    end

    posts_by_title = Post.where('title ILIKE ?', "%#{search}%")
    posts_by_title.each do |post|
      unless final_product.include?(post.topic)
        final_product << post.topic
      end
    end
    final_product
  end

  # Instance method returns a list of posts
  def search(search)
    self.posts.where("title ILIKE ?", "%#{search}%")
    # this is where i need to add search by body to array then return array
  end
end

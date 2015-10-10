class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true

  default_scope { order(:id)}

  # Class method returns a list of topics
  def self.search(search, user)
    if search
      compatible_topics = []
      by_topic_name = user.topics.where('name ILIKE ?', "%#{search}%")
      by_topic_name.each do |topic|
        compatible_topics << topic
      end

      posts_by_title = Post.where('title ILIKE ?', "%#{search}%")
      posts_by_title.each do |post|
        unless compatible_topics.include?(post.topic)
          compatible_topics << post.topic
        end
      end

      posts_by_body = Post.where("body ILIKE ?", "%#{search}%")
      posts_by_body.each do |post|
        unless compatible_topics.include?(post.topic)
          compatible_topics << post.topic
        end
      end

      compatible_topics.compact
    else
      self.all
    end
  end

  # Instance method returns a list of posts
  def search(search)
    if search && search.size > 0
      ids = self.posts.where("title ILIKE ?", "%#{search}%").ids
      by_post_body = self.posts.where("body ILIKE ?", "%#{search}%").ids
      by_post_body.each do |post_id|
        ids << post_id
      end
      ids.compact! if ids.include?(nil)
      final = Post.where(id: ids)
    else
      self.posts
    end
  end
end

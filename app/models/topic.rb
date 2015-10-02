class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true

  def order_posts
    case self.posts_order
    when "Newest First"
      self.posts.sort_by(&:created_at).reverse
    when "Oldest First"
      self.posts.sort_by(&:created_at)
    when "A - Z"
      self.posts.sort_by(&:title)
    when "Z - A"
      self.posts.sort_by(&:title).reverse
    when "Highest Rank"
      self.posts.ranked
    when "Lowest Rank"
     self.posts.ranked.reverse
    end
  end
end

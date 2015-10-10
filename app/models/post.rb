class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :user, through: :topic

  validates :title, presence: true
  validates :topic, presence: true

  default_scope {order("created_at DESC")}
  scope :ranked, -> {reorder('rank DESC')}
  scope :updated_at, -> {reorder('updated_at DESC')}

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def sum
    up_votes - down_votes
  end

  def update_rank
    age_in_days = (Time.now - self.created_at) / 86400
    new_rank = sum * 2 - age_in_days
    update_attribute(:rank, new_rank)
  end

  def self.order_posts
    case self.all.first.topic.posts_order
    when "Newest First"
      self.all.sort { |a, b| b[:created_at] <=> a[:created_at] }
    when "Oldest First"
      self.all.sort_by(&:created_at)
    when "A - Z"
      self.all.sort_by { |post| post[:title].downcase}
    when "Z - A"
      self.all.sort { |a, b| b[:title].downcase <=> a[:title].downcase }
    when "Highest Points"
      self.all.sort { |a, b| b.sum <=> a.sum }
    when "Lowest Points"
      self.all.sort_by { |post| post.sum }
    end
  
    
  end
end

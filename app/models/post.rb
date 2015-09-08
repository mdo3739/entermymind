class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :user, through: :topic

  validates :title, presence: true
  validates :topic, presence: true

  default_scope {order("created_at DESC")}
  scope :ranked, -> {reorder('rank DESC')}

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
end

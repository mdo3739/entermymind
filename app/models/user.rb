class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :posts, through: :topics
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def admin?
    role == 'Da Boss'
  end

  def points
    points = 0
    self.posts.each do |post|
      points += post.sum
    end
    points
  end
end

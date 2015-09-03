class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :topic, presence: true
end

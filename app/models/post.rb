class Post < ActiveRecord::Base
  belongs_to :topic

  validates :title, presence: true
  validates :topic, presence: true
end

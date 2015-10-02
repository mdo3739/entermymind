class AddPostsOrderToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :posts_order, :string, default: 'Newest First'
  end
end

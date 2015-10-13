class AddDescriptionToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :description, :text, default: ""
  end
end

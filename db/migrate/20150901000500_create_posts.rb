class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :topic, index: true, foreign_key: true
      t.boolean :public, default: true

      t.timestamps null: false
    end
  end
end

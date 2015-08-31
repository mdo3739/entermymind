class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.boolean :public, default: true
      t.timestamps null: false
    end
  end
end

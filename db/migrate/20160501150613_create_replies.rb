class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :puntos
      t.references :user, index: true, foreign_key: true
      t.references :contribution, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :replies, [:user_id, :created_at]
    add_index :replies, [:comment_id, :created_at]
  end
end

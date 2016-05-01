class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :puntos
      t.references :user, index: true, foreign_key: true
      t.references :contribution, index: true, foreign_key: true
      
      t.timestamps null: false
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:contribution_id, :created_at]
  end
end

class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :titulo
      t.string :url
      t.integer :puntos
      t.text :text
      t.string :tipo
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
      
    end
      add_index :contributions, [:user_id, :created_at]
  end
end

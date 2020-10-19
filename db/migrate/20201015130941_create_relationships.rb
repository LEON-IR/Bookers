class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
    	t.integer :follower_id
      t.integer :following_id
    	t.datetime :created_at, null: false
    	t.datetime :updated_at, null: false
    	t.references :user, foreign_key: true
    	t.references :follow, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end

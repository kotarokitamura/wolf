class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.timestamp :last_checked_at

      t.timestamps
    end
  end
end

class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.integer :follower
      t.integer :followed

      t.timestamps
    end
  end
end

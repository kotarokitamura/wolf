class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :body
      t.string :provider
      t.integer :hold_flag, :default => 0
      t.timestamp :posted_at

      t.timestamps
    end
  end
end

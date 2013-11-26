class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :title
      t.string :body
      t.integer :hold_flag

      t.timestamps
    end
  end
end

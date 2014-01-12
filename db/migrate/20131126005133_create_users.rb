class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, :unique => true
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :image_url
      t.string :email
      t.string :access_token
      t.timestamp :last_checked_at

      t.timestamps
    end
  end
end

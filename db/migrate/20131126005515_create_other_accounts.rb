class CreateOtherAccounts < ActiveRecord::Migration
  def change
    create_table :other_accounts do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :name
      t.string :image_url
      t.string :email
      t.string :access_token

      t.timestamps
    end
  end
end

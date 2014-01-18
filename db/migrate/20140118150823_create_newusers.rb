class CreateNewusers < ActiveRecord::Migration
  def change
    create_table :newusers do |t|
      t.string :email, index: true
      t.string :encrypted_password
      t.string :confirmation_token
      t.string :remember_token, index: true

      t.string :github_token
      t.boolean :github_private
      t.string :dropbox_token
      t.string :dropbox_uid
      t.string :moves_token

      t.json :extra_info
      t.boolean :admin

      t.timestamps
    end
  end
end

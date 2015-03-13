class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    # not needed ---- add_column :users, :, :string
  end
end

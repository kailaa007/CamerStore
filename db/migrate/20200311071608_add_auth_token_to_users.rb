class AddAuthTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end

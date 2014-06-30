class AddAddressToReceiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_to_receive, :string
  end
end

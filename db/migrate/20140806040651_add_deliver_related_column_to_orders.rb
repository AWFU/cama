class AddDeliverRelatedColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_type, :string
    add_column :orders, :package_tracking_no, :string
  end
end

class AddIscodToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :iscod, :string
  end
end

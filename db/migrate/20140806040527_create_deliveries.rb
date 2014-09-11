class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.string :tracking_url
      t.integer :fee_per_item

      t.timestamps
    end
  end
end

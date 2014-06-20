class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :ordernum
      t.string :buyer_name
      t.string :buyer_tel
      t.string :receiver_name
      t.string :receiver_tel
      t.string :receiver_address
      t.string :payment_type
      t.string :payment_status

      t.timestamps
    end
  end
end

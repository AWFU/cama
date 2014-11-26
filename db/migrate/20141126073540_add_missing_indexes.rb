class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :announcements, [:id, :type]
    add_index :announcements, :article_id
    add_index :orderitems, :order_id
    add_index :galleries, [:attachable_id, :attachable_type]
    add_index :galleries, [:id, :type]
    add_index :banners, [:id, :type]
    add_index :products, :product_cate_id
    add_index :products, :article_id
    add_index :product_cates, :parent_id
    add_index :talks, :article_id
    add_index :orderlogs, :order_id
    add_index :addressbooks, :user_id
    add_index :photos, :article_id
    add_index :orderasks, :order_id
    add_index :product_stocks, :product_id
    add_index :orders, :user_id
  end
end


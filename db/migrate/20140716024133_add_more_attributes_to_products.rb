class AddMoreAttributesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :intro, :text
    add_column :products, :keypoints, :text
    add_column :products, :taste_attributes, :text
    add_column :products, :grindable, :integer
  end
end

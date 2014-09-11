class ChangeLftRgt < ActiveRecord::Migration
  def self.up 

    remove_column :product_cates, :lft
    remove_column :product_cates, :rgt
    
  end
  
  def self.down
  
    add_column :product_cates, :rgt, :integer
    add_column :product_cates, :lft, :integer

  end
end

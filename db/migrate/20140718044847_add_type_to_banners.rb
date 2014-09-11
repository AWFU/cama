class AddTypeToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :type, :string
  end
end

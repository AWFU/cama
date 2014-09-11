class AddTypeToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :type, :string
  end
end

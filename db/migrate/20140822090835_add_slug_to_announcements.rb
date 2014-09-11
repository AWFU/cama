class AddSlugToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :slug, :string , :unique => true
  end
end

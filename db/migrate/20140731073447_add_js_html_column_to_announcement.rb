class AddJsHtmlColumnToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :js_context, :text
    add_column :announcements, :html_context, :text
  end
end

class AddSubtitleToTalk < ActiveRecord::Migration
  def change
    add_column :talks, :subtitle, :string
  end
end

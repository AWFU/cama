class ChangeBannersStatusToString < ActiveRecord::Migration
  def change
    change_column :banners, :status, :string
  end
end

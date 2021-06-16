class ChangeImgaeUrlToImageUrl < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :imgae_url, :image_url
  end
end

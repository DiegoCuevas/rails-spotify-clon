class RemoveRatingFromAlbums < ActiveRecord::Migration[5.2]
  def change
    remove_column :albums, :rating, :integer
  end
end

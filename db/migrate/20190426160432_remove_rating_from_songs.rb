class RemoveRatingFromSongs < ActiveRecord::Migration[5.2]
  def change
    remove_column :songs, :rating, :integer
  end
end

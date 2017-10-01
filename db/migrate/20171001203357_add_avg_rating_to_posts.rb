class AddAvgRatingToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :avg_rating, :decimal
    add_index :posts, :avg_rating
  end
end

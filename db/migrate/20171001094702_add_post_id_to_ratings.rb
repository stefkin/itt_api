class AddPostIdToRatings < ActiveRecord::Migration[5.1]
  def change
    change_table :ratings do |t|
      t.belongs_to :post
    end
  end
end

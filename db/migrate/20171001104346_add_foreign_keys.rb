class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :posts, :users
    add_foreign_key :ratings, :posts
  end
end

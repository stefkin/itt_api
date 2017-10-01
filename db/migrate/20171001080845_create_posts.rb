class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :author_ip
      t.timestamps
      t.belongs_to :user
    end
  end
end

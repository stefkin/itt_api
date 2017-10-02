class AddAuthorIpIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :posts, :author_ip
  end
end

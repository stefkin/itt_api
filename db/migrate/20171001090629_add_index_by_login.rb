class AddIndexByLogin < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :login
  end
end

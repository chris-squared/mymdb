class RemoveNotSeenFromMovie < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :notseen
  end
end

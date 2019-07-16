class RemoveSeenIdFromMovie < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :seen_id
  end
end

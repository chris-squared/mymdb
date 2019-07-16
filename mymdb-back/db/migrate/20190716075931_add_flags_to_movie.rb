class AddFlagsToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :seen, :boolean
    add_column :movies, :notseen, :boolean
    add_column :movies, :favorite, :boolean
  end
end

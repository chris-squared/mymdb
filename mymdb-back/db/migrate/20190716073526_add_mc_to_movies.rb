class AddMcToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :mc, :string
  end
end

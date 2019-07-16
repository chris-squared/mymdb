class AddRtToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :rt, :string
  end
end

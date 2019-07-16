class AddStudioToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :studio, :string
  end
end

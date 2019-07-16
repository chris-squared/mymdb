class ChangeDefaultsMovie < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :seen, :boolean, default: false
    change_column :movies, :favorite, :boolean, default: false
  end
end

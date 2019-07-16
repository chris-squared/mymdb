class AddSeenRefToMovie < ActiveRecord::Migration[5.1]
  def change
    add_reference :movie, :seen, index: true
  end
end

class AddLatAndLongToTrunkLines < ActiveRecord::Migration[5.0]
  def change
    add_column :trunk_lines, :latitude, :float
    add_column :trunk_lines, :longitude, :float
  end
end

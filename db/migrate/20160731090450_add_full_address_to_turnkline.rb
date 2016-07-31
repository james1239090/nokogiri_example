class AddFullAddressToTurnkline < ActiveRecord::Migration[5.0]
  def change
    add_column :trunk_lines, :full_address, :string
  end
end

class CreateTrunkLines < ActiveRecord::Migration[5.0]
  def change
    create_table :trunk_lines do |t|
      t.string :respond_area
      t.integer :car_no
      t.integer :number
      t.string :dist
      t.string :vil
      t.string :address
      t.string :around_time
      t.string :recover_date

      t.timestamps
    end
  end
end

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.integer :sauna_area, null: false
      t.integer :sauna_temperature, null: false
      t.integer :loryu_type, null: false
      t.integer :aufguss, null: false
      t.integer :water_temperature, null: false
      t.integer :water_area, null: false
      t.integer :chair_count, null: false
      t.integer :price, null: false
      t.text :body, null: false
      t.integer :sauna_time, null: false
      t.integer :congestion, null: false
      t.float :evaluation, null: false
      t.timestamps
    end
  end
end

class AddLongitudeToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :longitude, :float
  end
end

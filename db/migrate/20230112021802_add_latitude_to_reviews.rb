class AddLatitudeToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :latitude, :float
  end
end

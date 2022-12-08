class CreateCommentFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_favorites do |t|
      t.integer :user
      t.integer :review
      t.integer :comment
      t.timestamps
    end
  end
end

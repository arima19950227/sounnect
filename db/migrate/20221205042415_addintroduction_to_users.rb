class AddintroductionToUsers < ActiveRecord::Migration[6.1]
  def change
    t.text :introduction
  end
end

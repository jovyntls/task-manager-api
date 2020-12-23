class AddUserToItemsTags < ActiveRecord::Migration[6.0]
  def change
    add_reference :items_tags, :user, null: false, foreign_key: true
  end
end

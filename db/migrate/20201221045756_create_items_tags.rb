class CreateItemsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :items_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :cat, null: false, foreign_key: true

      t.timestamps
    end
  end
end

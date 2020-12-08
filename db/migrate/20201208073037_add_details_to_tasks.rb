class AddDetailsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :priority, :integer, default: 0
    add_column :tasks, :completed, :boolean, default: false
    add_reference :tasks, :cat, null: false, foreign_key: true
  end
end

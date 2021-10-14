class CreateTasksTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags_tasks, id: false do |t|
      t.integer :task_id
      t.integer :tag_id
      t.timestamps
    end

    add_index :tags_tasks, :task_id
    add_index :tags_tasks, :tag_id
  end
end
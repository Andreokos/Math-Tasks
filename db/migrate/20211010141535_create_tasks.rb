class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :titl
      t.text :condition
      t.string :answer

      t.belongs_to :subject
      t.belongs_to :user

      t.timestamps
    end
  end
end

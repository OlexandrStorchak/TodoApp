class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
    add_reference :tasks, :user, type: :integer, foreign_key: true
  end
end

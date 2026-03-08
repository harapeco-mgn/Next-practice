class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description
      t.string :category, null: false
      t.string :difficulty, null: false, default: "beginner"
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :courses, :category
    add_index :courses, :difficulty
    add_index :courses, :position
  end
end

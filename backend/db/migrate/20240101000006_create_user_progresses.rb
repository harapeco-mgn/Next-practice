class CreateUserProgresses < ActiveRecord::Migration[8.1]
  def change
    create_table :user_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: true, foreign_key: true
      t.references :quiz, null: true, foreign_key: true
      t.string :status, null: false, default: "not_started"
      t.integer :score
      t.integer :selected_option_id

      t.timestamps
    end

    add_index :user_progresses, [:user_id, :lesson_id], unique: true,
              where: "lesson_id IS NOT NULL AND quiz_id IS NULL",
              name: "index_user_progresses_on_user_lesson"
    add_index :user_progresses, [:user_id, :quiz_id], unique: true,
              where: "quiz_id IS NOT NULL",
              name: "index_user_progresses_on_user_quiz"
  end
end

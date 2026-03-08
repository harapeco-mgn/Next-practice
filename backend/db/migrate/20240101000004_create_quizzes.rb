class CreateQuizzes < ActiveRecord::Migration[8.1]
  def change
    create_table :quizzes do |t|
      t.references :lesson, null: false, foreign_key: true
      t.text :question, null: false
      t.text :explanation
      t.string :quiz_type, null: false, default: "single_choice"
      t.text :correct_answer       # fill_in_blank 用
      t.text :starter_code         # code_challenge 用（編集可能ゾーン）
      t.text :test_code            # code_challenge 用（非公開テストケース）
      t.jsonb :hints, default: []  # code_challenge 用（段階的ヒント）
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :quizzes, [:lesson_id, :position]
  end
end

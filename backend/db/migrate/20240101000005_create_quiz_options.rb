class CreateQuizOptions < ActiveRecord::Migration[8.1]
  def change
    create_table :quiz_options do |t|
      t.references :quiz, null: false, foreign_key: true
      t.text :body, null: false
      t.boolean :correct, null: false, default: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :quiz_options, [:quiz_id, :position]
  end
end

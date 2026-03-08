# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2024_01_01_000006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "difficulty", default: "beginner", null: false
    t.integer "position", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_courses_on_category"
    t.index ["difficulty"], name: "index_courses_on_difficulty"
    t.index ["position"], name: "index_courses_on_position"
  end

  create_table "lessons", force: :cascade do |t|
    t.text "content"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "position"], name: "index_lessons_on_course_id_and_position"
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "quiz_options", force: :cascade do |t|
    t.text "body", null: false
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.bigint "quiz_id", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id", "position"], name: "index_quiz_options_on_quiz_id_and_position"
    t.index ["quiz_id"], name: "index_quiz_options_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.text "correct_answer"
    t.datetime "created_at", null: false
    t.text "explanation"
    t.jsonb "hints", default: []
    t.bigint "lesson_id", null: false
    t.integer "position", default: 0, null: false
    t.text "question", null: false
    t.string "quiz_type", default: "single_choice", null: false
    t.text "starter_code"
    t.text "test_code"
    t.datetime "updated_at", null: false
    t.index ["lesson_id", "position"], name: "index_quizzes_on_lesson_id_and_position"
    t.index ["lesson_id"], name: "index_quizzes_on_lesson_id"
  end

  create_table "user_progresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "lesson_id"
    t.bigint "quiz_id"
    t.integer "score"
    t.integer "selected_option_id"
    t.string "status", default: "not_started", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["lesson_id"], name: "index_user_progresses_on_lesson_id"
    t.index ["quiz_id"], name: "index_user_progresses_on_quiz_id"
    t.index ["user_id", "lesson_id"], name: "index_user_progresses_on_user_lesson", unique: true, where: "((lesson_id IS NOT NULL) AND (quiz_id IS NULL))"
    t.index ["user_id", "quiz_id"], name: "index_user_progresses_on_user_quiz", unique: true, where: "(quiz_id IS NOT NULL)"
    t.index ["user_id"], name: "index_user_progresses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "role", default: "user", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "lessons", "courses"
  add_foreign_key "quiz_options", "quizzes"
  add_foreign_key "quizzes", "lessons"
  add_foreign_key "user_progresses", "lessons"
  add_foreign_key "user_progresses", "quizzes"
  add_foreign_key "user_progresses", "users"
end

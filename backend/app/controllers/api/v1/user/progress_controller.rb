module Api
  module V1
    module User
      class ProgressController < ApplicationController
        include Authenticatable

        # GET /api/v1/user/progress
        # 全コースの進捗サマリー
        def index
          courses = ::Course.ordered

          summary = courses.map do |course|
            lessons       = course.lessons.ordered
            lesson_ids    = lessons.pluck(:id)
            quiz_ids      = ::Quiz.where(lesson_id: lesson_ids).pluck(:id)
            total_lessons = lesson_ids.count
            total_quizzes = quiz_ids.count

            completed_lessons = current_user.user_progresses
              .where(lesson_id: lesson_ids, quiz_id: nil, status: "completed")
              .count
            completed_quizzes = current_user.user_progresses
              .where(quiz_id: quiz_ids, status: "completed")
              .count

            total = total_lessons + total_quizzes
            completed = completed_lessons + completed_quizzes
            progress_pct = total > 0 ? (completed * 100 / total) : 0

            {
              course_id: course.id,
              title: course.title,
              category: course.category,
              difficulty: course.difficulty,
              total_lessons:,
              total_quizzes:,
              completed_lessons:,
              completed_quizzes:,
              progress_pct:
            }
          end

          render json: { progress: summary }
        end

        # GET /api/v1/user/progress/courses/:course_id
        # コース別詳細進捗
        def course
          course   = ::Course.find(params[:course_id])
          lessons  = course.lessons.ordered

          lesson_progress = lessons.map do |lesson|
            lesson_done = current_user.user_progresses
              .exists?(lesson:, quiz_id: nil, status: "completed")

            quiz_results = lesson.quizzes.ordered.map do |quiz|
              prog = current_user.user_progresses.find_by(quiz:)
              {
                quiz_id: quiz.id,
                status: prog&.status || "not_started",
                score: prog&.score
              }
            end

            {
              lesson_id: lesson.id,
              title: lesson.title,
              position: lesson.position,
              completed: lesson_done,
              quizzes: quiz_results
            }
          end

          render json: { course_id: course.id, title: course.title, lessons: lesson_progress }
        end
      end
    end
  end
end

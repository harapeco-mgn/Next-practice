module Api
  module V1
    class LessonsController < ApplicationController
      include Authenticatable
      skip_before_action :authenticate_user!, only: [:show]

      # GET /api/v1/lessons/:id
      def show
        lesson = ::Lesson.find(params[:id])
        siblings = lesson.course.lessons.ordered.to_a
        current_index = siblings.index(lesson)

        prev_lesson = siblings[current_index - 1] if current_index > 0
        next_lesson = siblings[current_index + 1]

        quizzes = lesson.quizzes.ordered.map { |q| quiz_json(q) }

        render json: {
          lesson: lesson_json(lesson).merge(
            prev_lesson_id: prev_lesson&.id,
            next_lesson_id: next_lesson&.id,
            quizzes:
          )
        }
      end

      # POST /api/v1/lessons/:id/complete
      def complete
        lesson = ::Lesson.find(params[:id])
        progress = ::UserProgress.find_or_initialize_by(
          user: current_user,
          lesson:,
          quiz: nil
        )
        progress.update!(status: "completed")
        render json: { status: "completed" }
      end

      private

      def lesson_json(lesson)
        {
          id: lesson.id,
          course_id: lesson.course_id,
          title: lesson.title,
          content: lesson.content,
          position: lesson.position
        }
      end

      def quiz_json(quiz)
        {
          id: quiz.id,
          question: quiz.question,
          quiz_type: quiz.quiz_type,
          position: quiz.position,
          starter_code: quiz.starter_code,
          hints: quiz.hints,
          quiz_options: quiz.quiz_options.ordered.map do |opt|
            { id: opt.id, body: opt.body, position: opt.position }
          end
        }
      end
    end
  end
end

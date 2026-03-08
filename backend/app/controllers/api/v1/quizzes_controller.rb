module Api
  module V1
    class QuizzesController < ApplicationController
      include Authenticatable
      skip_before_action :authenticate_user!, only: [:show]

      # GET /api/v1/quizzes/:id
      def show
        quiz = ::Quiz.find(params[:id])
        render json: { quiz: quiz_json(quiz) }
      end

      # POST /api/v1/quizzes/:id/answer
      def answer
        quiz = ::Quiz.find(params[:id])
        correct = judge(quiz, params)

        # 進捗を記録
        ::UserProgress.find_or_create_by!(
          user: current_user,
          quiz:,
          lesson: nil
        ).update!(
          status: correct ? "completed" : "in_progress",
          score: correct ? 100 : 0
        )

        render json: { correct:, explanation: quiz.explanation }
      end

      private

      def judge(quiz, params)
        case quiz.quiz_type
        when "single_choice", "true_false"
          judge_single(quiz, params[:selected_option_ids])
        when "multiple_choice"
          judge_multiple(quiz, params[:selected_option_ids])
        when "fill_in_blank", "code_challenge"
          judge_fill(quiz, params[:answer])
        else
          false
        end
      end

      def judge_single(quiz, ids)
        return false if ids.blank?
        selected_id = Array(ids).map(&:to_i).first
        correct_id  = quiz.quiz_options.find_by(correct: true)&.id
        selected_id == correct_id
      end

      def judge_multiple(quiz, ids)
        return false if ids.blank?
        selected_ids = Array(ids).map(&:to_i).sort
        correct_ids  = quiz.quiz_options.where(correct: true).pluck(:id).sort
        selected_ids == correct_ids
      end

      def judge_fill(quiz, answer)
        return false if answer.blank? || quiz.correct_answer.blank?
        answer.to_s.strip.downcase == quiz.correct_answer.strip.downcase
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

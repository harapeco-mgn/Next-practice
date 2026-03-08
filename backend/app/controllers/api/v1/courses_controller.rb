module Api
  module V1
    class CoursesController < ApplicationController
      # GET /api/v1/courses
      def index
        courses = ::Course.ordered
        courses = courses.by_category(params[:category]) if params[:category].present?
        courses = courses.by_difficulty(params[:difficulty]) if params[:difficulty].present?

        render json: { courses: courses.map { |c| course_json(c) } }
      end

      # GET /api/v1/courses/:id
      def show
        course  = ::Course.find(params[:id])
        lessons = course.lessons.ordered.to_a

        # 認証ユーザーの完了レッスン ID を取得
        completed_ids = if current_user
          current_user.user_progresses
            .where(lesson_id: lessons.map(&:id), quiz_id: nil, status: "completed")
            .pluck(:lesson_id)
            .to_set
        else
          Set.new
        end

        lesson_list = lessons.each_with_index.map do |l, i|
          # 1つ目は常に開放、2つ目以降は前レッスン完了で開放
          locked = i > 0 && !completed_ids.include?(lessons[i - 1].id)
          { id: l.id, title: l.title, position: l.position, locked: }
        end

        render json: { course: course_json(course).merge(lessons: lesson_list) }
      end

      private

      def current_user
        return @current_user if defined?(@current_user)
        token = request.headers["Authorization"]&.split(" ")&.last
        return @current_user = nil unless token
        payload = ::JwtService.decode(token)
        @current_user = ::User.find_by(id: payload[:user_id])
      rescue ApplicationController::AuthenticationError
        @current_user = nil
      end

      def course_json(course)
        {
          id: course.id,
          title: course.title,
          description: course.description,
          category: course.category,
          difficulty: course.difficulty,
          position: course.position
        }
      end
    end
  end
end

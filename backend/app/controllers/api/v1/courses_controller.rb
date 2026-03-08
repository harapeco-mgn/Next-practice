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
        course = ::Course.find(params[:id])
        lessons = course.lessons.ordered.map do |l|
          { id: l.id, title: l.title, position: l.position }
        end
        render json: { course: course_json(course).merge(lessons:) }
      end

      private

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

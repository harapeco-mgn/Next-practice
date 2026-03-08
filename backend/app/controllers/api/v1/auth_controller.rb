module Api
  module V1
    class AuthController < ApplicationController
      include Authenticatable
      skip_before_action :authenticate_user!, only: %i[register login]

      # POST /api/v1/auth/register
      def register
        user = ::User.new(register_params)
        if user.save
          token = ::JwtService.encode(user_id: user.id)
          render json: { token:, user: user_json(user) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # POST /api/v1/auth/login
      def login
        user = ::User.find_by(email: params[:email]&.downcase)
        if user&.authenticate(params[:password])
          token = ::JwtService.encode(user_id: user.id)
          render json: { token:, user: user_json(user) }
        else
          render json: { error: "メールアドレスまたはパスワードが正しくありません" }, status: :unauthorized
        end
      end

      # GET /api/v1/auth/me
      def me
        render json: { user: user_json(current_user) }
      end

      private

      def register_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

      def user_json(user)
        { id: user.id, name: user.name, email: user.email, role: user.role }
      end
    end
  end
end

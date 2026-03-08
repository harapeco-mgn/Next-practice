class ApplicationController < ActionController::API
  class AuthenticationError < StandardError; end

  rescue_from AuthenticationError, with: :render_unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_unauthorized(e)
    render json: { error: e.message.presence || "認証が必要です" }, status: :unauthorized
  end

  def render_not_found
    render json: { error: "リソースが見つかりません" }, status: :not_found
  end
end

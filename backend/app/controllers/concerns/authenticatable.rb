module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  private

  def authenticate_user!
    token = extract_token
    raise ApplicationController::AuthenticationError, "トークンがありません" unless token

    payload = ::JwtService.decode(token)
    @current_user = ::User.find(payload[:user_id])
  rescue ActiveRecord::RecordNotFound
    raise ApplicationController::AuthenticationError, "ユーザーが見つかりません"
  end

  def extract_token
    header = request.headers["Authorization"]
    header&.split(" ")&.last
  end

  def current_user
    @current_user
  end
end

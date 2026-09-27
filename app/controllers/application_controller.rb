class ApplicationController < ActionController::Base
  before_action :authenticate_user

  helper_method :current_user

  def current_user
    return @current_user if @current_user

    token = cookies.signed[:auth_token]

    return nil unless token

    begin
      decoded_token = JwtService.decode(token)
      user_id = decoded_token[0]["user_id"]

      @current_user = User.find_by(id: user_id)
    rescue JWT::DecodeError
      nil
    end
  end

  private

  def authenticate_user
    unless current_user
      render plain: "Unauthorized", status: :unauthorized
    end
  end
end

class UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [ :signup, :createuser, :login, :authenticate ]
  def signup
    @user = User.new
  end

  def createuser
    @user = User.new(user_params)

    if @user.save
      redirect_to "/"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def login
  end

  def authenticate
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      @token = JwtService.encode(user.id)
      cookies.signed[:auth_token] = {
        value: @token,
        httponly: true,
        secure: Rails.env.production?,
        same_site: :lax,
        expires: 24.hours.from_now
      }

      redirect_to "/products"
    else
      render :login, status: :unauthorized
    end
  end

  def profile
     render plain: "Logged in user: #{current_user.name}"
  end

  def logout
    cookies.delete(:auth_token)

    redirect_to "/login"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

class UsersController < ApplicationController
  include JwtAuthenticator
  before_action :jwt_authenticate, except: :create

  def create
    user = User.new(user_params)
    if user.save
      render json: user.as_json(except: :password_digest)
    else
      render json: user.errors
    end
  end

  def show
    render json: @current_user.as_json(except: :password_digest)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end

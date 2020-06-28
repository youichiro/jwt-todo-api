class SessionsController < ApplicationController
  include JwtAuthenticator

  def create
    current_user = User.find_by(email: params[:email])
    if current_user&.authenticate(params[:password])
      jwt_token = encode(current_user.id)
      response.headers['X-Authentication-Token'] = jwt_token
      render json: current_user
    else
      render json: { message: 'unauthorized'}, status: 401
    end
  end
end

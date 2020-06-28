module JwtAuthenticator
  require 'jwt'

  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base

  def jwt_authenticate
    unless request.headers['Authorization']
      return render json: { message: 'unauthorized' }, status: 401
    end
    encoded_token = request.headers['Authorization'].split('Bearer ').last
    payload = decode(encoded_token)
    @current_user = User.find(payload['user_id'])
    unless @current_user
      return render json: { message: 'unauthorized' }, status: 401
    end
    @current_user
  end

  def encode(user_id)
    expires_in = 1.month.from_now.to_i
    preload = { user_id: user_id, expires: expires_in }
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end

  def decode(encoded_token)
    decoded_token = JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256')
    decoded_token.first
  end
end

module AuthHelper
  include UsersHelper
  def user_signed_in?
    decode_session.present?
  end

  def current_user
    UserData.new(decode_session)
  end

  private

  def generate_session_token(options, admin)
    require 'jwt'
    payload = { data: { email: options['email'],
                        sub: options['sub'],
                        name: options['name'],
                        avatar: options['picture'],
                        admin: } }

    JWT.encode payload, ENV['SESSION_SECRET'], 'HS256'
  end

  def decode_session
    require 'jwt'
    auth_session = cookies[:auth_session]

    return nil unless auth_session.present?

    decoded_token = JWT.decode auth_session, ENV['SESSION_SECRET'], true, { algorithm: 'HS256' }

    return nil unless decoded_token[0].present?

    decoded_token[0]['data']
  end
end

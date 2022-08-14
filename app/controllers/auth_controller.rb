class AuthController < ApplicationController
  before_action :require_no_authentication, except: :logout
  before_action :require_authentication, only: :logout
  before_action :validate_google_csrf, only: :create

  # GET /auth
  def index; end

  # GET /logout
  def logout
    cookies.delete(:auth_session)
    cookies.delete(:g_state)

    redirect_to auth_index_path
  end

  # POST /auth
  def create
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: ENV['G00GLE_OAUTH_CLIENT_ID'])
    email = payload['email']
    name = payload['name']
    avatar = payload['picture']

    # JWT is valid. Lookup or create user account and sign them in.
    user = User.find_by_email(payload['email'])

    if user.nil?
      new_user = User.new({ name:, email:, avatar:, remaining_days: 0 })
      new_user.save
    else
      user.update({ name:, avatar: })
    end

    cookies[:auth_session] = { value: generate_session_token(payload, user.nil? ? false : user.admin),
                               expires: 48.hour,
                               secure: true,
                               httponly: true,
                               same_site: :strict }

    redirect_to root_path
  rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError
    # The JWT could not be validated. Redirect or raise an exception here.
    redirect_to auth_index_path
  end

  private

  def validate_google_csrf
    # Google One Tap provides its own csrf token and stores it in the cookie
    # along with including it in the request.
    if cookies['g_csrf_token'].blank? ||
       params['g_csrf_token'].blank? ||
       cookies['g_csrf_token'].blank? != params['g_csrf_token'].blank?
      # Mismatched or missing g_csrf_token. Redirect, or raise an exception here.

      redirect_to auth_index_path
    end
  end
end

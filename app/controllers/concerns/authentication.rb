module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def require_no_authentication
      return unless user_signed_in?

      redirect_to root_path
    end

    def require_authentication
      return if user_signed_in?

      redirect_to auth_index_path
    end
  end
end

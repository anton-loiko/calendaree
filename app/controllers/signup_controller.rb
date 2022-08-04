class SignupController < ApplicationController
  before_action :set_user, only: %i[edit update]

  # POST /signup
  def index; end

  # POST /signup
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/' }
      else
        format.html { render :index, status: :forbidden }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by params[:email]
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end

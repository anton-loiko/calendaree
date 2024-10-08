class UsersController < ApplicationController
  include UsersHelper

  before_action :require_authentication
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.ordered
  end

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    @user = User.new({ remaining_days: 0 })
    @domain = ENV['ALLOWED_EMAIL_DOMAIN']
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      respond_to do |format|
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    respond_to do |format|
      format.turbo_stream
    end

    redirect_to users_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :avatar, :work_time, :remaining_days, :admin, :discord_username)
  end
end

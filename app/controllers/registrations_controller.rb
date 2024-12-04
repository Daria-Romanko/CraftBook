class RegistrationsController < ApplicationController
  skip_before_action :require_authentication
  def new
    @user = User.new
  end

  def create
    existing_user = User.find_by("LOWER(email_address) = ?", user_params[:email_address].downcase)

    if existing_user
      @user = User.new(user_params)
      @user.errors.add(:base, "Такой пользователь уже зарегистрирован.")
      render :new
    else
      @user = User.new(user_params)
      if @user.save
        redirect_to new_session_path, notice: "Registration successful. Please log in."
      else
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end

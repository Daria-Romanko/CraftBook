class RegistrationsController < ApplicationController
  skip_before_action :require_authentication

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    existing_user = User.find_by("LOWER(email_address) = ?", user_params[:email_address]&.downcase)

    if existing_user
      @user.errors.add(:email_address, "уже зарегистрирован")
      render :new, status: :unprocessable_entity
    elsif @user.save
      redirect_to new_session_path, notice: "Регистрация успешна. Пожалуйста, войдите в систему."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end

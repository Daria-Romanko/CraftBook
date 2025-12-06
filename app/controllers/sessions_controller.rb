class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> {
    redirect_to new_session_url, alert: "Слишком много попыток. Попробуйте позже."
  }

  def new
  end

  def create
    user = User.authenticate_by(params.permit(:email_address, :password))
    if user
      start_new_session_for(user)
      redirect_to after_authentication_url, notice: "Вход выполнен успешно."
    else
      user_exists = User.exists?([ "LOWER(email_address) = ?", params[:email_address]&.downcase ])
      if user_exists
        flash.now[:alert] = "Неверный пароль. Попробуйте еще раз."
      else
        flash.now[:alert] = "Пользователь с таким email не найден."
      end
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "Вы успешно вышли из системы."
  end
end

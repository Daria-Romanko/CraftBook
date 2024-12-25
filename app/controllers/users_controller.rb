class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :destroy, :delete ]

  def show
  end

  def delete
  end

  def destroy
    @user.destroy
    terminate_session
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.action(:redirect, root_path) }
      format.html { redirect_to root_path, notice: "Аккаунт успешно удален." }
    end
  end

  private

  def set_user
    @user = User.find_by(id: resume_session.user_id)
  end
end

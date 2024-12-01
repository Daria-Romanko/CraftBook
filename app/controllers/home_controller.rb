class HomeController < ApplicationController
  before_action :redirect_if_authenticated
  def index
  end

  private

  def redirect_if_authenticated
    if authenticated?
      redirect_to projects_path, notice: "You are already logged in."
    end
  end
end

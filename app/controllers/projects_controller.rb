class ProjectsController < ApplicationController
  before_action :set_user

  def index
    @projects = @user.projects
  end

  def new
  end

  def create
    if Project.exists?(name: project_params[:name])
      flash[:alert] = "Проект с таким именем уже существует."
      redirect_to new_project_path
    else
      @project = Project.new(project_params)
      @project.user = @user
      if @project.save
        redirect_to project_path(@project), notice: "Проект успешно создан."
      else
        flash.now[:alert] = "Произошла ошибка при создании проекта."
        render :new
      end
    end
  end

  def show
    @project = @user.projects.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      # Успешное обновление
    else
      # Обработка ошибок
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end

  private

  def set_user
    @user = Current.user || User.find(session[:user_id]) # или другой способ получения текущего пользователя
  end

  def project_params
    params.require(:project).permit(:name)
  end
end

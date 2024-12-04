class ProjectsController < ApplicationController
  before_action :set_user

  def index
    @projects = @user.projects
  end

  def new
  end

  def edit
    @project = Project.find(params[:id])
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
    @recipes = @project.recipes
    @ingredients = @project.ingredients
    @tags = Tag.joins(:recipes).where(recipes: { id: @recipes.pluck(:id) }).distinct
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path, notice: "Проект успешно переименован."
    else
      flash.now[:alert] = "Произошла ошибка."
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end

  private

  def set_user
    @user = Current.user || User.find(session[:user_id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end

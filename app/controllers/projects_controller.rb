class ProjectsController < ApplicationController
  before_action :set_user
  before_action :set_project, except: [ :index, :new, :create ]

  def index
    @projects = @user.projects
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def delete
  end

  def create
    @project = Project.new(project_params)
    @project.user = @user

    respond_to do |format|
      if Project.exists?(name: project_params[:name])
        flash.now[:alert] = "Проект с таким именем уже существует."
        format.turbo_stream { render turbo_stream: turbo_stream.replace("project_form", partial: "projects/form", locals: { project: @project }) }
        format.html { redirect_to new_project_path, alert: "Проект с таким именем уже существует." }
      elsif @project.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("projects", partial: "projects/project", locals: { project: @project }) }
        format.html { redirect_to project_path(@project), notice: "Проект успешно создан." }
      else
        flash.now[:alert] = "Произошла ошибка при создании проекта."
        format.turbo_stream { render turbo_stream: turbo_stream.replace("project_form", partial: "projects/form", locals: { project: @project }) }
        format.html { render :new }
      end
    end
  end
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("project_#{@project.id}", partial: "projects/project", locals: { project: @project }) }
      else
        flash.now[:alert] = "Произошла ошибка при переименовании проекта."
        format.turbo_stream { render turbo_stream: turbo_stream.replace("project_form", partial: "projects/form", locals: { project: @project }) }
        format.html { render :edit }
      end
    end
  end

  def show
    @recipes = @project.recipes
    @ingredients = @project.ingredients
    @tags = @project.tags
  end

  def destroy
  @project.destroy
  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.remove("project_#{@project.id}"),
        turbo_stream.update("modalBox", { action: "remove" })
      ]
    end
    format.html { redirect_to projects_path, notice: "Проект успешно удален." }
  end
  end

  def export
    respond_to do |format|
      format.html
      format.json {
        render json: JSON.pretty_generate(@project.as_json),
             filename: "#{@project.name.parameterize}.json",
             content_type: "application/json"
      }
    end
  end

  private

  def set_user
    @user = Current.user || User.find(session[:user_id])
  end

  def set_project
    @project = @user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end

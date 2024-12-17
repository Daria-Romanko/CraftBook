class IngredientsController < ApplicationController
  before_action :set_project, only: [ :index, :new, :create ]
  def index
    @project = Project.find(params[:project_id])
    @ingredients = @project.ingredients

    respond_to do |format|
      format.turbo_stream { render partial: "projects/ingredients", locals: { ingredients: @ingredients } }
      format.html # fallback for non-Turbo requests
    end
  end

  def new
  end

  def create
    @ingredient = @project.ingredients.new(ingredient_params)

  respond_to do |format|
    if @ingredient.save
      format.turbo_stream { render turbo_stream: turbo_stream.append("ingredients", partial: "ingredients/ingredient", locals: { ingredient: @ingredient }) }
      format.html { redirect_to project_path(@project), notice: "Ингредиент успешно добавлен." }
    else
      flash.now[:alert] = "Произошла ошибка при добавлении ингредиента."
      format.turbo_stream { render turbo_stream: turbo_stream.replace("ingredient_form", partial: "ingredients/form", locals: { ingredient: @ingredient }) }
      format.html { render :new }
    end
  end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, :image)
  end
end

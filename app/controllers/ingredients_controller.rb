class IngredientsController < ApplicationController
  before_action :set_project

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = @project.ingredients.new(ingredient_params)
    if @ingredient.save
      redirect_to project_path(@project), notice: "Ингредиент успешно добавлен."
    else
      flash.now[:alert] = "Произошла ошибка при добавлении ингредиента."
      render :new
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name,  :description)
  end
end

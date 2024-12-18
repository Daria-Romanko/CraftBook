class RecipesController < ApplicationController
  before_action :set_project
  before_action :set_recipe, only: [ :show, :destroy, :add_ingredient, :edit, :update ]

  def index
    @recipes = @project.recipes
  end

  def show
  end

  def destroy
    @recipe.destroy
    redirect_to project_path(@project), notice: "Рецепт был успешно удален."
  end

  def new
    @recipe = @project.recipes.new
  end

  def create
    @recipe = @project.recipes.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        format.turbo_stream { render turbo_stream: turbo_stream.action(:redirect, project_recipe_path(@project, @recipe)) }
        format.html { redirect_to project_recipe_path(@project, @recipe) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("modal", partial: "recipes/new_modal", locals: { recipe: @recipe }) }
      end
    end
  end


  def edit
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to project_recipe_path(@project, @recipe), notice: "Рецепт успешно переименован" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("recipe_header", partial: "recipes/recipe_name", locals: { recipe: @recipe }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("modal", partial: "recipes/edit_modal", locals: { recipe: @recipe, project: @project, title: "Переименование рецепта" }) }
      end
    end
  end

  def add_ingredient
    if params[:ingredient_id].present? && params[:quantity].present?
      ingredient_id = params[:ingredient_id]
      quantity = params[:quantity]

      existing_record = @recipe.ingredient_recipes.find_by(ingredient_id: ingredient_id)
      if existing_record
        existing_record.update(quantity: quantity)
        notice_message = "Количество ингредиента обновлено"
      else
        @recipe.ingredient_recipes.create(ingredient_id: ingredient_id, quantity: quantity)
        notice_message = "Ингредиент добавлен"
      end
      redirect_to project_recipe_path(@project, @recipe), notice: notice_message
    else
      flash[:alert] = "Пожалуйста, выберите ингредиент и укажите количество."
      redirect_to project_recipe_path(@project, @recipe)
    end
  end

  def add_tag
  end

  def destroy
      @recipe = @project.recipes.find(params[:id])
      @recipe.destroy
      redirect_to project_path(@project), notice: "Рецепт успешно удален."
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def recipe_params
    params.require(:recipe).permit(
    :name,
    ingredient_recipes_attributes: [ :id, :ingredient_id, :quantity, :_destroy ]
  )
  end
end

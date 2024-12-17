class RecipesController < ApplicationController
  before_action :set_project

  def index
    @recipes = @project.recipes
  end

  def new
    @recipe = @project.recipes.new
  end
  def create
    @recipe = @project.recipes.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        format.turbo_stream { render turbo_stream: turbo_stream.action(:redirect, edit_project_recipe_path(@project, @recipe)) }
        format.html { redirect_to edit_project_recipe_path(@project, @recipe) }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("recipe_form", partial: "recipes/form", locals: { recipe: @recipe })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  def edit
    @recipe = @project.recipes.find(params[:id])
    @ingredients = Ingredient.all
    @tags = Tag.all
  end

  def update
    @recipe = @project.recipes.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to project_path(@project), notice: "Рецепт успешно обновлен."
    else
      @ingredients = Ingredient.all
      @tags = Tag.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
      @recipe = @project.recipes.find(params[:id])

      # Удаляем рецепт и все связанные записи
      @recipe.destroy

      # Перенаправляем на страницу проекта с сообщением об успешном удалении
      redirect_to project_path(@project), notice: "Рецепт успешно удален."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      ingredient_recipes_attributes: [ :id, :ingredient_id, :quantity, :_destroy ],
      recipe_tags_attributes:     [ :id, :tag_id, :quantity, :_destroy ]
    )
  end
end

class RecipesController < ApplicationController
  before_action :set_project
  before_action :set_recipe, except:  [ :new, :create ]

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

      end
    end
  end


  def edit
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("info_recipe", partial: "recipes/info_recipe", locals: { recipe: @recipe }) }
        format.html { redirect_to project_recipe_path(@project, @recipe), notice: "Рецепт успешно изменен" }
      else

      end
    end
  end

  def add_ingredient
    if params[:ingredient_id].present? && params[:quantity].present?
      ingredient_id = params[:ingredient_id]
      quantity = params[:quantity]

      existing_record = @recipe.ingredient_recipes.find_by(ingredient_id: ingredient_id)
    if existing_record
      if existing_record.quantity.to_i == quantity.to_i
          respond_to do |format|
            format.html { redirect_to project_recipe_path(@project, @recipe) }
          end
          nil
      else
          existing_record.update(quantity: quantity)
          @ingredient_recipe = existing_record
          respond_to do |format|
              format.turbo_stream { render turbo_stream: turbo_stream.replace("ingredient_#{@ingredient_recipe.ingredient.id}", partial: "ingredient_card", locals: { ingredient: @ingredient_recipe.ingredient, quantity: @ingredient_recipe.quantity, ingredient_recipe: @ingredient_recipe }) }
             format.html { redirect_to project_recipe_path(@project, @recipe), notice: notice_message }
           end
           nil
      end
    else
      @ingredient_recipe = @recipe.ingredient_recipes.create(ingredient_id: ingredient_id, quantity: quantity)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.append(
          "ingredients_list",
          partial: "ingredient_card",
          locals: { ingredient: @ingredient_recipe.ingredient, quantity: @ingredient_recipe.quantity, ingredient_recipe: @ingredient_recipe })
        }
        format.html { redirect_to project_recipe_path(@project, @recipe), notice: notice_message }
      end
    end

    else
      flash[:alert] = "Пожалуйста, выберите ингредиент и укажите количество."
      redirect_to project_recipe_path(@project, @recipe)
    end
  end

  def add_tag
    if params[:tag_id].present? && params[:quantity].present?
      tag_id = params[:tag_id]
      quantity = params[:quantity]

      existing_record = @recipe.recipe_tags.find_by(tag_id: tag_id)
    if existing_record
      if existing_record.quantity.to_i == quantity.to_i
          respond_to do |format|
            format.html { redirect_to project_recipe_path(@project, @recipe) }
          end
          nil
      else
          existing_record.update(quantity: quantity)
          @recipe_tag = existing_record
          respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.replace("tag_#{@recipe_tag.tag.id}", partial: "tag_card", locals: { tag: @recipe_tag.tag, quantity: @recipe_tag.quantity, recipe_tag: @recipe_tag  }) }
            format.html { redirect_to project_recipe_path(@project, @recipe), notice: "Тег добавлен" }
          end
          nil
      end
    else
      @recipe_tag = @recipe.recipe_tags.create(tag_id: tag_id, quantity: quantity)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.append(
          "tags_list",
          partial: "tag_card",
          locals: { tag: @recipe_tag.tag, quantity: @recipe_tag.quantity, recipe_tag: @recipe_tag })
        }
        format.html { redirect_to project_recipe_path(@project, @recipe), notice: notice_message }
      end
    end
    else
      flash[:alert] = "Пожалуйста, выберите тег и укажите количество."
      redirect_to project_recipe_path(@project, @recipe)
    end
  end

  def remove_ingredient
    @ingredient_recipe = IngredientRecipe.find_by(id: params[:ingredient_recipe_id])
        ingredient_id = @ingredient_recipe.ingredient.id
        @ingredient_recipe.destroy
         respond_to do |format|
           format.turbo_stream { render turbo_stream: turbo_stream.remove("ingredient_#{ingredient_id}") }
           format.html { redirect_to project_recipe_path(@project, @recipe), notice: "Ингредиент удален" }
         end
  end

  def remove_tag
    @recipe_tag = RecipeTag.find(params[:recipe_tag_id])
    tag_id = @recipe_tag.tag.id
    @recipe_tag.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("tag_#{tag_id}") }
      format.html { redirect_to project_recipe_path(@project, @recipe), notice: "Тег удален" }
    end
  end

  def delete
  end

  def destroy
      @recipe.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove("recipe_#{@recipe.id}") }
        format.html { redirect_to project_path(@project), notice: "Рецепт успешно удален." }
      end
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_recipe
    @recipe = @project.recipes.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
    :name, :description, :image,
    ingredient_recipes_attributes: [ :id, :ingredient_id, :quantity, :_destroy ]
  )
  end
end

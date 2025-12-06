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
    if params[:item_id].present? && params[:item_type].present? && params[:quantity].present?
      item_id = params[:item_id]
    item_type = params[:item_type]
    quantity = params[:quantity]

    if item_type == "Ingredient"
      existing_record = @recipe.ingredient_recipes.find_by(ingredient_id: item_id)
      item_key = :ingredient
    elsif item_type == "Recipe"
      existing_record = @recipe.recipe_recipes.find_by(recipe_item_id: item_id)
      item_key = :recipe_item
    end

    if existing_record
      if existing_record.quantity.to_i == quantity.to_i
        respond_to do |format|
          format.html { redirect_to project_recipe_path(@project, @recipe) }
        end
        nil
      else
        existing_record.update(quantity: quantity)
        @item_recipe = existing_record
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace("#{item_key}_#{@item_recipe.send("#{item_key}").id}", partial: "item_card", locals: { item_recipe: @item_recipe }) }
          format.html { redirect_to project_recipe_path(@project, @recipe), notice: "Обновлено" }
        end
        nil
      end
    else
      if item_type == "Ingredient"
        @item_recipe = @recipe.ingredient_recipes.create(ingredient_id: item_id, quantity: quantity)
      elsif item_type == "Recipe"
        @item_recipe = @recipe.recipe_recipes.create(recipe_item_id: item_id, quantity: quantity)
      end

      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.append(
            "items_list",
            partial: "item_card",
            locals: { item_recipe: @item_recipe }
          )
        }
        format.html { redirect_to project_recipe_path(@project, @recipe), notice: success_message }
      end
    end
    else
    flash[:alert] = "Пожалуйста, выберите ингредиент/рецепт и укажите количество."
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
        format.html { redirect_to project_recipe_path(@project, @recipe), notice: "Создано" }
      end
    end
    else
      flash[:alert] = "Пожалуйста, выберите тег и укажите количество."
      redirect_to project_recipe_path(@project, @recipe)
    end
  end

  def remove_ingredient
    @item_recipe = nil

    if params[:ingredient_recipe_id].present?
      @item_recipe = IngredientRecipe.find_by(id: params[:ingredient_recipe_id])
    elsif params[:recipe_recipe_id].present?
      @item_recipe = RecipeRecipe.find_by(id: params[:recipe_recipe_id])
    end

    if @item_recipe
      item_id = @item_recipe.is_a?(IngredientRecipe) ? @item_recipe.ingredient.id : @item_recipe.recipe_item.id
      @item_recipe.destroy

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove("#{@item_recipe.is_a?(IngredientRecipe) ? "ingredient_#{item_id}" : "recipe_#{item_id}" }") }
        format.html { redirect_to project_recipe_path(@project, @recipe), notice: "#{@item_recipe.is_a?(IngredientRecipe) ? 'Ингредиент' : 'Рецепт'} удален" }
      end
    else
      flash[:alert] = "Не удалось найти запись."
      redirect_to project_recipe_path(@project, @recipe)
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

  def export
    @project = Project.includes(recipes: [ :tags, ingredient_recipes: :ingredient ], ingredients: :tags).find(params[:id])
    render json: project_as_json(@project)
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

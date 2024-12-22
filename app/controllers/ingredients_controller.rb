class IngredientsController < ApplicationController
  before_action :set_project
  before_action :set_ingredient, except: [ :new, :create ]

  def index
    @ingredients = @project.ingredients
  end

  def new
      @ingredient = @project.ingredients.new
  end

  def create
    @ingredient = @project.ingredients.new(ingredient_params)
    respond_to do |format|
      if @ingredient.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("ingredients_section_cards", partial: "projects/ingredient_card", locals: { ingredient: @ingredient }) }
        format.html { redirect_to project_path(@project), notice: "Ингредиент успешно добавлен." }
      else
        flash.now[:alert] = "Произошла ошибка при добавлении ингредиента."
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("ingredient_#{@ingredient.id}", partial: "projects/ingredient_card", locals: { ingredient: @ingredient }) }
        format.html { redirect_to project_path(@project), notice: "Ингредиент успешно изменен" }
      else

      end
    end
  end

  def delete
  end

  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("ingredient_#{@ingredient.id}") }
      format.html { redirect_to project_path(@project), notice: "Ингредиент успешно удален." }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_ingredient
      @ingredient = @project.ingredients.find(params[:id])
    end

    def ingredient_params
      params.require(:ingredient).permit(:name, :description, :image)
    end
end

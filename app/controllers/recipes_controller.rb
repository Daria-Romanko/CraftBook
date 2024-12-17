class RecipesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @recipes = @project.recipes

    respond_to do |format|
      format.turbo_stream { render partial: "projects/recipes", locals: { recipes: @recipes } }
      format.html # fallback for non-Turbo requests
    end
  end
end

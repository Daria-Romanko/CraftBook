class TagsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tags = @project.tags

    respond_to do |format|
      format.turbo_stream { render partial: "projects/tags", locals: { tags: @tags } }
      format.html # fallback for non-Turbo requests
    end
  end
end

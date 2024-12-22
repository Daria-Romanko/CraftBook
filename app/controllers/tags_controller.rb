class TagsController < ApplicationController
  before_action :set_project
  before_action :set_tag, except:  [ :new, :create ]

  def index
    @project = Project.find(params[:project_id])
    @tags = @project.tags
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = @project.tags.new(tag_params)
    respond_to do |format|
      if @tag.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("tags_section_cards", partial: "projects/tag_card", locals: { tag: @tag }) }
        format.html { redirect_to project_path(@project) }
      else

      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tag_#{@tag.id}", partial: "projects/tag_card", locals: { tag: @tag }) }
        format.html { redirect_to project_path(@project), notice: "Тег успешно изменен" }
      else

      end
    end
  end

  def delete
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("tag_#{@tag.id}") }
      format.html { redirect_to project_path(@project), notice: "Тег успешно удален." }
    end
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_tag
    @tag = @project.tags.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :quantity, :description, :image)
  end
end

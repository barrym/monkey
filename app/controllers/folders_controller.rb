class FoldersController < ApplicationController

  before_filter :find_folder, :only => [:show, :add_new_entities]

  def index
    @folders = Folder.all
  end

  def show
    @entities = @folder.recent_children
  end

  private

  def find_folder
    @folder = Folder.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that folder"
    redirect_to folders_path
  end
end

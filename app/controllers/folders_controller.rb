class FoldersController < ApplicationController

  before_filter :find_folder, :only => [:show]

  def index
    @folders = Folder.all
  end

  def show
    @entities = @folder.children.find(:all, :order => 'id desc', :limit => 20)
  end

  private

  def find_folder
    @folder = Folder.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that folder"
    redirect_to folders_path
  end
end

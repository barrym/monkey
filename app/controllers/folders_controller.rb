class FoldersController < ApplicationController

  before_filter :find_folder, :only => [:show, :add_new_entities]

  def index
    @folders = Folder.all
  end

  def show
    # @entities = @folder.children.find(:all, :order => 'id desc', :limit => 20)
    @entities = @folder.recent_children
  end

  def add_new_entities
    @loaded_entities = params[:loaded_entities].split(",")
    @new_entities = @folder.recent_children.reject {|c| @loaded_entities.include?(c.id.to_s)}
    logger.info(@new_entities.inspect)
    render :update do |page|
      unless @new_entities.empty?
        @new_entities.each do |post|
          page.insert_html(:top, 'entities', :partial => 'posts/show', :locals => {:post => post, :hide_post => true})
          page << "Effect.SlideDown('#{dom_id(post)}')"
          # page[dom_id(post)].highlight
          page << "loaded_entities.push(#{post.id})"
        end
      end
    end
  end

  private

  def find_folder
    @folder = Folder.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that folder"
    redirect_to folders_path
  end
end

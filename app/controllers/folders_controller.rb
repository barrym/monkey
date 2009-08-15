class FoldersController < ApplicationController

  before_filter :find_folder, :only => [:show, :add_new_entities]

  def index
    @folders = Folder.all
  end

  def show
    @entities = @folder.recent_children
  end

  # def add_new_entities
  #   @loaded_entities = params[:loaded_entities].split(",")
  #   @loaded_comments = params[:loaded_comments].split(",")
  #   @recent_entities = @folder.recent_children

  #   @new_entities = @recent_entities.reject {|c| @loaded_entities.include?(c.id.to_s)}

  #   @new_comments = (@recent_entities - @new_entities).collect {|e| e.comments}.flatten.reject {|c| @loaded_comments.include?(c.id.to_s)}

  #   logger.info(@new_entities.inspect)
  #   render :update do |page|
  #     unless @new_entities.empty?
  #       @new_entities.each do |post|
  #         page.insert_html(:top, 'entities', :partial => 'posts/post', :locals => {:post => post, :hide_post => true})
  #         page << "Effect.SlideDown('#{dom_id(post)}', {duration: 0.5})"
  #         # page[dom_id(post)].highlight
  #         page << "loaded_entities.push(#{post.id})"
  #       end
  #     end
  #     unless @new_comments.empty? || current_user.user_setting.display_mode == 'classic'
  #       @new_comments.each do |comment|
  #         page.insert_html(:bottom, dom_id(comment.entity), :partial => 'comments/comment', :locals => {:comment => comment})
  #         page << "Effect.SlideDown('#{dom_id(comment)}', {duration: 0.5})"
  #         # page[dom_id(post)].highlight
  #         page << "loaded_comments.push(#{comment.id})"
  #       end
  #     end
  #     # sleep 3
  #     # page << "console.log('finished')"
  #     # page << "console.log(checking_entities)"
  #     # logger.info("done")
  #   end
  # end

  private

  def find_folder
    @folder = Folder.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that folder"
    redirect_to folders_path
  end
end

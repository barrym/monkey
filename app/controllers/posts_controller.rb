class PostsController < ApplicationController

  before_filter :find_folder

  def create
    # TODO: some validations here
    @post = Post.create!(params[:post].merge(:parent => @folder, :user => current_user))
    if request.xhr?
      logger.info("omg ajax")
      render :update do |page|
        page << 'hideNewPostForm()'
        page << "$('post_subject').clear()"
        page << "$('post_body').clear()"
        page.insert_html(:top, 'entities', :partial => 'posts/show', :locals => {:post => @post})
        # page.insert_html(:top, 'entities', :partial => 'posts/show', :locals => {:post => @post, :hide_post => true})
        # page << "Effect.SlideDown('#{dom_id(@post)}')"
      end
    else

    end
  rescue => e
    # Handle crap
  end

  def find_folder
    @folder = Folder.find(params[:folder_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that folder"
    redirect_to folders_path
  end
end

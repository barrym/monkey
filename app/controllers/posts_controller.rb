class PostsController < ApplicationController

  before_filter :find_folder

  def create
    # TODO: some validations here
    @post = Post.create!(params[:post].merge(:parent => @folder, :user => current_user))
    if request.xhr?
      render :update do |page|
        page << 'clearNewPostForm()'
        page.insert_html(:top, 'entities', :partial => 'posts/show', :locals => {:post => @post})
        page[dom_id(@post)].highlight
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

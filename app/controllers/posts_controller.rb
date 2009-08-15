class PostsController < ApplicationController

  before_filter :find_folder

  def show
    @post = Post.find(params[:id])
  end

  def create
    # TODO: some validations here
    @post = @folder.posts.create!(params[:post].merge(:user => current_user))
    if request.xhr?
      render :juggernaut => {:type => :send_to_channels, :channels => [@folder.juggernaut_channel]} do |page|
        # page << 'clearNewPostForm()'
        # page.insert_html(:top, 'entities', :partial => 'posts/post', :locals => {:post => @post})
        # page << "loaded_entities.push(#{@post.id})"
        # page[dom_id(@post)].highlight
        page.insert_html(:top, 'entities', :partial => 'posts/post', :locals => {:post => @post, :hide_post => true})
        page << "Effect.SlideDown('#{dom_id(@post)}', {'duration':0.3})"
      end
    else

    end
  rescue => e
    debugger
    nil
    # Handle crap
  end

  def find_folder
    @folder = Folder.find(params[:folder_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that folder"
    redirect_to folders_path
  end
end

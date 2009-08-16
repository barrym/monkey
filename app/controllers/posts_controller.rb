class PostsController < ApplicationController

  # before_filter :find_folder

  def show
    @post = Post.find(params[:id])
  end

  def create
    # TODO: some validations here
    @post = Post.create!(params[:post].merge(:user => current_user))
    if request.xhr?
      render :juggernaut => {:type => :send_to_channels, :channels => @post.category_ids.map{|id| "category_#{id}"}} do |page|
        page.insert_html(:top, 'entities', :partial => 'posts/post', :locals => {:post => @post, :hide_post => true})
        page << "Effect.SlideDown('#{dom_id(@post)}', {'duration':0.3})"
      end
    else

    end
  # rescue => e
  #   render :text => "DO SOMETHING TO FIX THIS"
  end

  # def find_folder
  #   @folder = Folder.find(params[:folder_id])
  # rescue ActiveRecord::RecordNotFound
  #   flash[:error] = "Cannot find that folder"
  #   redirect_to folders_path
  # end
end

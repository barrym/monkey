class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def create
    # TODO: some validations here
    @post = Post.create!(params[:post].merge(:user => current_user))
    if request.xhr?
      render :juggernaut => {:type => :send_to_channels, :channels => @post.juggernaut_channels} do |page|
        page.insert_html(:top, 'entities', :partial => 'posts/post', :locals => {:post => @post, :hide_post => true})
        page << "Effect.SlideDown('#{dom_id(@post)}', {'duration':0.3})"
      end
    else

    end
  # rescue => e
  #   render :text => "DO SOMETHING TO FIX THIS"
  end

end

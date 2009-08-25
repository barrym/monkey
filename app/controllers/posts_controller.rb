class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def display
    # TODO : check if post is found
    @post = Post.find(params[:id])
    if request.xhr?
      render :update do |page|
        page.insert_html(:top, 'entities', :partial => 'posts/post', :locals => {:post => @post, :hide_post => true})
        page << "Effect.SlideDown('#{dom_id(@post)}', {'duration':0.5})"
      end
    else

    end
  end

  def create
    # TODO: some validation should happen here
    @post = Post.create!(params[:post].merge(:user => current_user, :category_ids => params[:category_ids].split(',')))
    if request.xhr?
      render :juggernaut => {:type => :send_to_channels, :channels => @post.juggernaut_channels} do |page|
        page << "displayNewPost('#{@post.id}');"
      end
      render false
    else

    end
  rescue => e
    render :text => "DO SOMETHING TO FIX THIS"
  end

end

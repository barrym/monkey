class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def display
    # TODO : check if post is found
    @post = Post.find(params[:id])
    if request.xhr?
      post_partial = render_to_string :partial => 'posts/post', :locals => {:post => @post, :hide_post => true}
      render :update do |page|
        page << "$j('#entities').prepend('#{escape_javascript(post_partial)}');"
        page << "$j('##{dom_id(@post)}_container').slideDown(1000);"
      end
    else

    end
  end

  def create
    # TODO: some validation should happen here
    category_ids = Category.find(:all, :conditions => {:name => params[:categories].strip.split(',').map(&:strip)}).map(&:id)
    @post = Post.new(params[:post].merge(:user => current_user, :category_ids => category_ids))

    if request.xhr?
      if @post.valid?
        @post.save!

        render :juggernaut => {:type => :send_to_clients, :client_ids => [current_user.id]} do |page|
          page << "clearNewPostForm();"
        end

        render :juggernaut => {:type => :send_to_channels, :channels => @post.juggernaut_channels} do |page|
          page << "displayNewPost('#{@post.id}');"
        end

        render false
      else
        error_div = render_to_string :partial => 'shared/error_dialog', :locals => {:errors => @post.errors}
        render :update do |page|
          page << "$j('#{escape_javascript(error_div)}').dialog({modal:true, buttons: { Ok: function() { $j(this).dialog('close'); } }})"
        end
      end
    else
      # not ajax
    end
  # rescue => e
  #   render :text => "DO SOMETHING TO FIX THIS"
  end

end

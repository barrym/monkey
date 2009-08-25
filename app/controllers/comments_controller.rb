class CommentsController < ApplicationController

  before_filter :load_entity, :only => [:create]

  def display
    @comment = Comment.find(params[:id])
  # //   Element.insert(entity_dom_id + '_comments', {bottom: content});
  # //   // Effect.SlideDown(comment_dom_id, {duration: 0.5});
  # //   $(comment_dom_id).highlight();
    if request.xhr?
      render :update do |page|
        page.insert_html(:bottom, "#{dom_id(@comment.entity)}_comments", :partial => 'comments/comment', :locals => {:comment => @comment, :hide => true})
        page << "Effect.SlideDown('#{dom_id(@comment)}', {'duration':0.5})"
      end
    else

    end
  end

  def create
    @comment = @entity.comments.create(:user => current_user, :body => params[:comment][:body])
    if request.xhr?
      # html_output = render_to_string :partial => 'comments/comment', :locals => {:comment => @comment}
      render :juggernaut => {:type => :send_to_channels, :channels => @comment.entity.juggernaut_channels} do |page|
        # page << "displayNewComment('#{dom_id(@entity)}', '#{dom_id(@comment)}', '#{escape_javascript(html_output)}');"
        page << "displayNewComment('#{dom_id(@entity)}', '#{@comment.id}');"
        # page.replace_html("#{dom_id(@comment.entity)}_comments", :partial => 'comments/comments', :locals => {:entity => @comment.entity})
      end
    else
      # TODO not ajax
    end
  end

  private

  def load_entity
    @entity = params[:entity_type].constantize.find(params[:entity_id])
  rescue ActiveRecord::RecordNotFound
    # TODO do something
  end
end

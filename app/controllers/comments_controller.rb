class CommentsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :load_entity, :only => [:create]

  def display
    @comment = Comment.find(params[:id])
    if request.xhr?
      comment_partial = render_to_string :partial => 'comments/comment', :locals => {:comment => @comment, :hide => true}
      render :update do |page|
        page << "$j('##{dom_id(@comment.entity)}_comments').append('#{escape_javascript(comment_partial)}')"
        page << "$j('##{dom_id(@comment)}').slideDown(700)";
      end
    else

    end
  end

  def create
    @comment = @entity.comments.create(:user => current_user, :body => params[:comment][:body])
    if request.xhr?
      render :juggernaut => {:type => :send_to_channels, :channels => @comment.entity.juggernaut_channels} do |page|
        page << "displayNewComment('#{dom_id(@entity)}', '#{@comment.id}');"
      end
      render :text => 'juggernaut seems to do some weird shit'
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

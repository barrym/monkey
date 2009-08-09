class CommentsController < ApplicationController

  before_filter :load_entity, :only => [:create]

  def create
    @comment = @entity.comments.create(:user => current_user, :body => params[:comment][:body])
    if request.xhr?
      render :update do |page|
        page << "loaded_comments.push(#{@comment.id})"
        page << "hideCommentForm('#{dom_id(@entity)}')"
        page.insert_html(:bottom, dom_id(@entity), :partial => 'comments/comment', :locals => {:comment => @comment})
        page[dom_id(@comment)].highlight
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

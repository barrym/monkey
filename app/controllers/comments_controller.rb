class CommentsController < ApplicationController

  before_filter :load_entity, :only => [:create]

  def create
    @comment = @entity.comments.create(:user => current_user, :body => params[:comment][:body])
    if request.xhr?
      html_output = render_to_string :partial => 'comments/comment', :locals => {:comment => @comment}
      render :juggernaut => {:type => :send_to_channels, :channels => [@comment.entity.folders.first.juggernaut_channel]} do |page|
        page << "displayNewComment('#{dom_id(@entity)}', '#{dom_id(@comment)}', '#{escape_javascript(html_output)}');"
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

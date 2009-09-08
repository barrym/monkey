class SharedLinksController < ApplicationController
  def display
    # TODO : check if post is found
    @shared_link = SharedLink.find(params[:id])
    if request.xhr?
      shared_link_partial = render_to_string :partial => 'shared_links/shared_link', :locals => {:shared_link => @shared_link, :hide_shared_link => true}
      render :update do |page|
        page << "$j('#entities').prepend('#{escape_javascript(shared_link_partial)}');"
        page << "$j('##{dom_id(@shared_link)}').slideDown(1000);"
      end
    else

    end
  end
end

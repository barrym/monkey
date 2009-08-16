class SiteController < ApplicationController

  before_filter :authenticate, :except => [:index, :bookmarklet]

  def bookmarklet
    render :action => 'bookmarklet', :layout => 'bookmarklet'
  end

end

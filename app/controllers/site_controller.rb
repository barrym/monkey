class SiteController < ApplicationController

  before_filter :authenticate, :except => [:index]

end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_layout_variables

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def set_layout_variables
    @main_columns = 19
    @entity_columns = @main_columns - 2 # entity_containers are full main width with prepend-1 and prepend-2
    @sidebar_columns = 5
  end
end

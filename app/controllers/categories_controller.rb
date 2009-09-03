class CategoriesController < ApplicationController

  before_filter :find_category, :only => [:show]

  def index
    @categories = Category.all
  end

  def show
    per_page = signed_in? ? current_user.user_setting.items_per_page : ITEMS_PER_PAGE
    @entities = @category.entities(:page => (params[:page] || 1), :per_page => per_page)
  end

  private

  def find_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that category"
    redirect_to categories_path
  end

end

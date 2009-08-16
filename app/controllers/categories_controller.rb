class CategoriesController < ApplicationController

  before_filter :find_category, :only => [:show]

  def index
    @categories = Category.all
  end

  def show
  end

  private

  def find_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find that category"
    redirect_to categories_path
  end

end

class UsersController < Clearance::UsersController

  before_filter :find_user, :only => [:show, :edit, :update]

  def index
    @users = User.all
  end

  # def new
  #   render :text => "nope"
  # end

  def edit
    if @user != current_user
      flash[:error] = "You cannot do that"
      redirect_to users_path
    end
  end

  def show
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    end
  end

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "User not found"
    redirect_to users_path
  end
end

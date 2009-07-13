class UsersController < Clearance::UsersController

  def index
    @users = User.all
  end

  # def new
  #   render :text => "nope"
  # end

end

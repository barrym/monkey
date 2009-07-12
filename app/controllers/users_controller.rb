class UsersController < Clearance::UsersController

  def index
    @users = User.all
  end

end

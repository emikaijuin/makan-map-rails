class Api::V1::UsersController < Api::V1::ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      message = "Saved user."
    else
      message = user.errors
    end

    render :json => { "user": user, "message": message }
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end

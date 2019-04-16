class Api::V1::UsersController < Api::V1::ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      message = "Saved user."
      status = 200
    else
      message = user.errors
      status = 400
    end

    render json: { "user": user, "message": message }, status: status
  end

  def index
    sql_query = "%#{params[:query]}%"
    @users =  if params[:query]
                User.where("first_name ILIKE ? OR last_name ILIKE ? OR username ILIKE ?", sql_query, sql_query, sql_query)
              else
                User.all
              end

    render json: @users, status: status
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end

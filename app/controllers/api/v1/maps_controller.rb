class Api::V1::MapsController < Api::V1::ApplicationController
  before_action :authenticate_user

  def index
    render :json => { hello: "world" }
  end
end

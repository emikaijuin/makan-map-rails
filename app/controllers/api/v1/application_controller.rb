module Api
  module V1
    class ApplicationController < ActionController::API
      include Knock::Authenticable
    end
  end
end
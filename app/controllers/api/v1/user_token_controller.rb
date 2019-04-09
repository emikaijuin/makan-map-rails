module Api
  module V1
    class UserTokenController < Knock::AuthTokenController
      skip_before_action :verify_authenticity_token, raise: false

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end

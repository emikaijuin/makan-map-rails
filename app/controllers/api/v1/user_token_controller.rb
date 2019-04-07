module Api
  module V1
    class UserTokenController < Knock::AuthTokenController
      skip_before_action :verify_authenticity_token, raise: false

      def user_params
        # camel case from react state
        params.require(:user).permit(:firstName, :lastName, :email, :password, :passwordConfirmation)
      end
    end
  end
end

module Api
  module V1
    class UserTokenController < Knock::AuthTokenController
      def index
        byebug
        # return :json => {'hello': 'world'}
      end

      def create
      end
    end
  end
end

module Admin
  class ApplicationController < ::ApplicationController
    before_action :verify_role, :verify_user_is_not_deactivated

    private
    def verify_user_is_not_deactivated
      sign_out unless current_user.active?
    end

    def verify_role
      show_access_denied and return unless current_user.admin?
    end

    def show_access_denied
      render json: {msg: "You don't have permission!"}, status: 401 and return false if request.format.symbol == :json
      render 'common/access_denied', status: 401
      return false
    end
  end
end

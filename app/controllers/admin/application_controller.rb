module Admin
  class ApplicationController < ::ApplicationController
    before_action :verify_role

    private
    def verify_role
      render :unauthorized and return unless current_user.admin?
    end
  end
end

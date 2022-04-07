class UsersController < BaseController

    before_action :find_user, only: %w[show]
  
    def show
      render json: { data: @user }, status: :ok
    end
  
    private
  
    def find_user
      @user = User.find(params[:id])
    end
  
  end
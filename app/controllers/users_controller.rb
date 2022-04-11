class UsersController < BaseController

    before_action :find_user, only: %w[show]
  
    def show
      render json: { data: @user }, status: :ok
    end
  
    private
  
    def find_user
      @user = User.find(params[:id])
    end

    def generate_jwt
      JWT.encode({ id: id,
                  exp: 60.days.from_now.to_i },
                 Rails.application.secrets.secret_key_base)
    end
    
  
  end
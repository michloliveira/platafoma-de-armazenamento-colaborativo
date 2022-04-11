class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])
    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
      redirect_to arquivos_path 
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity # lançar erro 
    end
  end

  def delete 
    @current_user = nil
    sign_out user
    # render "static_pages#index"
    render json: { message: "You are logged out" }
  end
end